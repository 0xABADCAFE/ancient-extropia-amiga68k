//****************************************************************************//
//**                                                                        **//
//**  File:          prefabutil.cpp ($NAME=prefabutil.cpp)                  **//
//**                                                                        **//
//**  Description:   Map block prefab utility class definition              **//
//**  Comment(s):    Provides text-based loading and saving for editing     **//
//**                                                                        **//
//**  First Started: 2003-01-18                                             **//
//**  Last Updated:  2003-01-23                                             **//
//**                                                                        **//
//**  Author(s):     Karl Churchill                                         **//
//**                                                                        **//
//**  Copyright:     (C)1998-2003, eXtropia Studios                         **//
//**                 Serkan YAZICI, Karl Churchill                          **//
//**                 All Rights Reserved.                                   **//
//**                                                                        **//
//****************************************************************************//


#include "prefab.hpp"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char PREFAB_EDIT::buf[256] = {0};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PREFAB_EDIT::Create(size_t nTris, size_t nVerts, size_t nVNorms, size_t nFNorms, size_t nPConsts)
{
  if (vertices)
    return ERR_RSC_LOCKED;
  if (Set(nTris, nVerts, nVNorms, nFNorms, nPConsts)==OK)
  {
    // Allocate maximum space
    const size_t allocSize = maxTris*(4*sizeof(VEC3D) + 3*sizeof(VERTEX) + sizeof(PREFAB_BASE::TRIDEF) + sizeof(float32));
    void *mem = MEM::Alloc(allocSize, true, MEM::ALIGN_CACHE);
    if (!mem)
      return ERR_NO_FREE_STORE;
    vertices        = (VERTEX*)mem;
    vertNorms       = (VEC3D*)(vertices + 3*maxTris);
    faceNorms       = vertNorms + maxTris;
    planeConsts     = (float32*)(faceNorms + maxTris);
    tris            = (TRIDEF*)(planeConsts + maxTris);
    return OK;
  }
  return ERR_VALUE;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PREFAB_EDIT::Delete()
{
  if (vertices)
    MEM::Free(vertices);
  vertices = 0;
  Zero();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool PREFAB_EDIT::ReadTextTri(size_t i)
{
  if (i<0 || i>numTris)
    return false;

  sint32 tex, v1, v2, v3, n1, n2, n3, fn, pc, solid, trans;
  if (sscanf(buf+1, " { %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d }",
      &tex, &v1, &v2, &v3, &n1, &n2, &n3, &fn, &pc, &solid, &trans)!=11)
  {
    puts("Malformed triangle definition");
    return false;
  }
  if (tex<0 || tex>255) {
    printf("Illegal texture index %ld\n", tex);
    return false;
  }
  else if (v1<0 || v1>=numVerts) {
    printf("Illegal vertex index %ld\n", v1);
    return false;
  }
  else if (v2<0 || v2>=numVerts || v2 == v1) {
    printf("Illegal vertex index %ld\n", v2);
    return false;
  }
  else if (v3<0 || v3>=numVerts || v3 == v2 || v3 == v1) {
    printf("Illegal vertex index %ld\n", v3);
    return false;
  }
  else if (n1<0 || n1>=numVertNorms) {
    printf("Illegal vertex normal index %ld\n", n1);
    return false;
  }
  else if (n2<0 || n2>=numVertNorms) {
    printf("Illegal vertex normal index %ld\n", n2);
    return false;
  }
  else if (n3<0 || n3>=numVertNorms) {
    printf("Illegal vertex normal index %ld\n", n3);
    return false;
  }
  else if (fn<0 || fn>=numFaceNorms) {
    printf("Illegal face normal index %ld\n", fn);
    return false;
  }
  else if (pc<0 || pc>=numPlaneConsts) {
    printf("Illegal plane constant index %ld\n", pc);
    return false;
  }
  else if (solid<0 || solid>255) {
    printf("Illegal solid value %ld\n", solid);
    return false;
  }
  else if (trans<0 || trans>255) {
    printf("Illegal transparity %ld\n", trans);
    return false;
  }
  // all data validated
  tris[i].iTexture = tex;
  tris[i].iVertex1 = v1;
  tris[i].iVertex2 = v2;
  tris[i].iVertex3 = v3;
  tris[i].iVertexNorm1 = n1;
  tris[i].iVertexNorm2 = n2;
  tris[i].iVertexNorm3 = n3;
  tris[i].iFaceNorm = fn;
  tris[i].iPlaneConst = pc;
  tris[i].solid = solid;
  tris[i].trans = trans;
  tris[i].vis = 0;
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool PREFAB_EDIT::ReadTextVert(size_t i)
{
  if (i<0 || i>numVerts)
    return false;

  VERTEX *v = &(vertices[i]);
  if (sscanf(buf+1, " { %f, %f, %f, %f, %f, %x }",
      &(v->x), &(v->y), &(v->z), &(v->u), &(v->v), &(v->colour))!=6)
  {
    puts("Malformed vertex definition");
    return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool PREFAB_EDIT::ReadTextVNorm(size_t i)
{
  if (i<0 || i>numVertNorms)
    return false;

  VEC3D *v = &(vertNorms[i]);
  if (sscanf(buf+1, " { %f, %f, %f }", &(v->x), &(v->y), &(v->z))!=3)
  {
    puts("Malformed normal definition");
    return false;
  }
  float32 len = v->Magnitude();
  if (FloatCompare(len, 1.0)==false)
  {
    printf("Normal has erronious magnitude %8.5f, renormalizing\n", len);
    (*v) /= len;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool PREFAB_EDIT::ReadTextFNorm(size_t i)
{
  if (i<0 || i>numFaceNorms)
    return false;

  VEC3D *v = &(vertNorms[i]);
  if (sscanf(buf+1, " { %f, %f, %f }", &(v->x), &(v->y), &(v->z))!=3)
  {
    puts("Malformed normal definition");
    return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool PREFAB_EDIT::ReadTextPConst(size_t i)
{
  if (i<0 || i>numPlaneConsts)
    return false;

  float32 *f = &(planeConsts[i]);
  if (sscanf(buf+1, " %f", f)!=1)
  {
    puts("Malformed plane constant");
    return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PREFAB_EDIT::ReadText(const char* fileName)
{
  if (!fileName)
    return ERR_PTR_ZERO;

  xFILEIO file(fileName, xIOS::READTEXT);

  if (file.Valid()==false)
    return ERR_FILE_OPEN;

  sint32 nTris = -1;
  sint32 nVerts = -1;
  sint32 nVNorms = -1;
  sint32 nFNorms = -1;
  sint32 nPConsts = -1;

  file.ReadText(buf, 255, '\n', 1); // read first line
  if (sscanf(buf, "PrefabDef %ld, %ld, %ld, %ld, %ld", \
            &nTris, &nVerts, &nVNorms, &nFNorms, &nPConsts)!=5)
  {
    puts("PREFAB_EDIT::ReadText() - [error] invalid prefab definition");
    return -1;
  }

  if (Create(nTris, nVerts, nVNorms, nFNorms, nPConsts)!=OK)
    return -1;
  if (numTris==0) // null prefab
    return OK;

  sint32 line         = 1;
  sint32 trisRead     = 0;
  sint32 vertsRead    = 0;
  sint32 vNormsRead   = 0;
  sint32 fNormsRead   = 0;
  sint32 pConstsRead  = 0;
  bool endDef         = false;

  while(file.EndOfFile()==false && endDef==false)
  {
    if (file.ReadText(buf, 255, '\n', 1)>0)
    {
      line++;
      switch(buf[0])
      {
        case 't':
        case 'T': // triangle definition
          if (trisRead < numTris) {
            if (ReadTextTri(trisRead)==true)
              trisRead++;
          }
          break;

        case 'v':
        case 'V': // vertex definition
          if (vertsRead < numVerts) {
            if (ReadTextVert(vertsRead)==true)
              vertsRead++;
          }
          break;

        case 'n':
        case 'N': // vertex normal definition
          if (vNormsRead < numVertNorms) {
            if (ReadTextVNorm(vNormsRead)==true)
              vNormsRead++;
          }
          break;

        case 'f':
        case 'F': // face normal definition
          if (fNormsRead < numFaceNorms) {
            if (ReadTextFNorm(fNormsRead)==true)
              fNormsRead++;
          }
          break;

        case 'p':
        case 'P': // plane constant definition
          if (pConstsRead < numPlaneConsts) {
            if (ReadTextPConst(pConstsRead)==true)
              pConstsRead++;
          }
          break;

        case ';':   // comment
        case '\n':  // line
        case '\r':  // line
          break;

        case '#':
          if (trisRead<numTris)
            printf("[warning] Read only %d / %d triangles\n", trisRead, numTris);
          if (vertsRead<numVerts)
            printf("[warning] Read only %d / %d vertices\n", vertsRead, numVerts);
          if (vNormsRead<numVertNorms)
            printf("[warning] Read only %d / %d vertex normals\n", vNormsRead, numVertNorms);
          if (fNormsRead<numFaceNorms)
            printf("[warning] Read only %d / %d face normals\n", fNormsRead, numFaceNorms);
          if (pConstsRead<numPlaneConsts)
            printf("[warning] Read only %d / %d plane consts\n", pConstsRead, numPlaneConsts);
          endDef = true;
          break;

        default:
          printf("Warning : unknown token '%c' on line %ld\n", buf[0], line);
          break;
      }
    }
    else
      endDef = true;
  }
  file.Close();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PREFAB_EDIT::WriteText(const char* fileName)
{
  if (!fileName)
    return ERR_PTR_ZERO;

  xFILEIO file(fileName, xIOS::WRITETEXT);
  if (file.Valid()==false)
    return ERR_FILE_OPEN;

  file.WriteText("PrefabDef %ld, %ld, %ld, %ld, %ld\n",
                  numTris,
                  numVerts,
                  numVertNorms,
                  numFaceNorms,
                  numPlaneConsts);

  file.WriteText("\n; Triangles [%d]\n", numTris);
  sint32 i;
  for (i=0; i<numTris; i++)
  {
    file.WriteText("t { %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d }\n",
                    tris[i].iTexture,
                    tris[i].iVertex1,
                    tris[i].iVertex2,
                    tris[i].iVertex3,
                    tris[i].iVertexNorm1,
                    tris[i].iVertexNorm2,
                    tris[i].iVertexNorm3,
                    tris[i].iFaceNorm,
                    tris[i].iPlaneConst,
                    tris[i].solid,
                    tris[i].trans);
  }
  file.WriteText("\n; Vertices [%d]\n", numVerts);
  for (i=0; i<numVerts; i++)
  {
    file.WriteText("v { %10.6f, %10.6f, %10.6f, %10.6f, %10.6f, 0x%08x }\n",
                    vertices[i].x,
                    vertices[i].y,
                    vertices[i].z,
                    vertices[i].u,
                    vertices[i].v,
                    (uint32)vertices[i].colour);
  }

  file.WriteText("\n; Vertex Normals [%d]\n", numVertNorms);
  for (i=0; i<numVertNorms; i++)
  {
    file.WriteText("n { %8.6f, %8.6f, %8.6f }\n",
                    vertNorms[i].x,
                    vertNorms[i].y,
                    vertNorms[i].z);
  }

  file.WriteText("\n; Face Normals [%d]\n", numFaceNorms);
  for (i=0; i<numFaceNorms; i++)
  {
    file.WriteText("f { %8.6f, %8.6f, %8.6f }\n",
                    faceNorms[i].x,
                    faceNorms[i].y,
                    faceNorms[i].z);
  }

  file.WriteText("\n; Plane Constants [%d]\n", numPlaneConsts);
  for (i=0; i<numPlaneConsts; i++)
  {
    file.WriteText("p %10.6f\n", planeConsts[i]);
  }

  file.WriteText("\n#\n; end of prefab definition\n");
  file.Close();

  return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int CompareTris(const void* a, const void* b)
{
  // Sort by transparency value, then if transparency same, sort by texture index
  // This is meant to ensure that fully opaque triangles are drawn first and that
  // we perform as few texture swaps as possible
  // Note transparency includes opaque polygons that have textures possesing alpha
  // transparency
  PREFAB_BASE::TRIDEF* t1 = (PREFAB_BASE::TRIDEF*)a;
  PREFAB_BASE::TRIDEF* t2 = (PREFAB_BASE::TRIDEF*)b;
  if (t1->trans == t2->trans)
    return ((int)(t1->iTexture)) - ((int)(t2->iTexture));
  else
    return ((int)(t1->trans)) - ((int)(t2->trans));
}

sint32 PREFAB_EDIT::SortTriangles()
{
  if (!tris || numTris<2)
    return ERR_PTR_ZERO;
  qsort(tris, numTris, sizeof(PREFAB_BASE::TRIDEF), CompareTris);
  return OK;
}
