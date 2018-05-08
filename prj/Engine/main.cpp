/*

  Extropia System Library test code by Karlos, eXtropia Studios

*/

#include "app.hpp"

int main()
{
  if (xBASELIB::Init() != OK)
  {
    puts("Error initialising base library");
    return 10;
  }

/*
  VEC3D p[3] = {
    VEC3D(1.0f,0.0f,0.0f),
    VEC3D(0.0f,1.0f,0.0f),
    VEC3D(0.0f,0.0f,1.0f)
  };

  VEC3D n[3] = {
    VEC3D(-1.0f,0.0f,0.0f),
    VEC3D(0.0f,-1.0f,0.0f),
    VEC3D(0.0f,0.0f,-1.0f)
  };
  sint32 i;

  static TRANSFORM t;

  t.Rotate(45.0*PI/180.0, 0.0, 0.0);

  for (i=0; i<3; i++)
  {
    printf("Before : v[%d] = [%8.5f, %8.5f, %8.5f]\n", i, p[i].x, p[i].y, p[i].z);
    p[i]*=t;
    printf("After  : v[%d] = [%8.5f, %8.5f, %8.5f]\n", i, p[i].x, p[i].y, p[i].z);
  }

  static TRANSFORM t2;

  t2.Rotate(0.0, 45.0*PI/180.0, 0.0);

  for (i=0; i<3; i++)
  {
    printf("Before : v[%d] = [%8.5f, %8.5f, %8.5f]\n", i, p[i].x, p[i].y, p[i].z);
    p[i]*=t2;
    printf("After  : v[%d] = [%8.5f, %8.5f, %8.5f]\n", i, p[i].x, p[i].y, p[i].z);
  }

  MILLICLOCK timer;
  rsint32 c = 10000;
  while (--c)
  {
    t*=t2; t*=t2;
    t*=t2; t*=t2;
    t*=t2; t*=t2;
    t*=t2; t*=t2;
    t*=t2; t*=t2;
  }
  i = timer.Elapsed();
  printf("TRANSFORM operator*=() test took %ld ms\n", i);
*/

  PREFAB_EDIT *test = new PREFAB_EDIT;
  if (test)
  {
    test->ReadText("data/test1.pfb");
    test->SortTriangles();
    test->WriteText("ram:test.pfb");
    delete test;
  }
  else
    puts("Failed to create PREFAB");
  xBASELIB::Done();
  return 0;
}