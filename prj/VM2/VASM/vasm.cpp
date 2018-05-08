//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Serkan YAZICI, Karl Churchill                **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include "vasm.hpp"

/////////////////////////////////////////////////////////////////////


ERRORMSG errorMsg("error_defs.txt");
INSTABLE instTable("op_defs.txt");


/////////////////////////////////////////////////////////////////////


int main(int argc, char *argv[])
{
  if (xBASELIB::Init() != OK){
    cerr << "Error initializing base library\n";
    return 10;
  }
  if(!instTable.Loaded())
    return 11;
  char asmFile[256]="", objFile[256]="";
  if(argc > 1){
    if(!strcmp(argv[1],"-?") || !strcmp(argv[1],"/?") || !strcmp(argv[1],"?")){
      cout << "eXtropia VM Assembler 1.0 running on " << X_ARCHITECTURE;
      cout << "\nBuilt Date: " << __DATE__ << " " << __TIME__ << "\n\n";
      cout << "Usage: vasm [in.vasm] [out.xvm]\n";
      cout << "       Assembles an eXtropia VM assembly code into VM object\n";
      cout << "       If input (asm) filename not provided, a prompt appears\n";
      cout << "       If output (object) filename not provided, input filename is used\n\n";
      xBASELIB::Done();
      return 0;
    }
    strcpy(asmFile,argv[1]);
    if(argc > 2)
      strcpy(objFile,argv[2]);
  }
  else {
    cout << "  Enter Input Assembly Filename: ";
    cin  >> asmFile;
  }

  if(!strcmp(objFile,"")){
    if(!strchr(asmFile,'.'))
      strcat(asmFile,".vasm");
    int len = strlen(asmFile);
    while(len>1 && asmFile[len]!='.')
      len--;
    strncpy(objFile,asmFile,len);
    objFile[len] = 0;
    strcat(objFile,".xvm");
  }

  //cout << "\n\tInput File: \"" << asmFile << "\"\tOutput File: \"" << objFile << "\"\n\n";

  PARSER parser;
  if(!parser.Load(asmFile)){
    int res = parser.Parse();
    if(res)
      parser.ReportError(res);
    cout << "\n\nParser returned: "<<res<<" at Line:"<<parser.Line()<<", Col:"<<parser.Col()<<"\n";
    {
      FILEIO f;
      f.Create("uncommented.txt");
      f.Write(parser.Buffer(),1,parser.Len());
      f.Close();
    }
    parser.Done();
  }
  xBASELIB::Done();
  return 0;
}


uint32 Hash(char *text)
{
  if(text){
    ruint8* p = (uint8*)text;
    ruint32 val = 0;
    while (*p) val = (val<<1)^*p++;
    return val;
  }
  return 0;
}


//// CLASS INSTABLE /////////////////////////////////////////////////


char* INSTABLE::INST::nextWord(char*s,char*word,int max)
{
  int i=0;
  while(*s && i<max && !isspace(*s))
    word[i++] = *(s++);
  if(!i || !(*s))
    return 0;       //Error
  word[i] = 0;
  return s;
}


int INSTABLE::INST::determineEA(char *ea)
{
  if(!stricmp(ea,"opt"))
    return EA_OPT;
  if(!stricmp(ea,"any"))
    return EA_ANY;
  if(!stricmp(ea,"dest"))
    return EA_DEST;
  if(!stricmp(ea,"regd"))
    return EA_REGD;
  if(!stricmp(ea,"off"))
    return EA_OFF;
  return EA_NONE;
}


int INSTABLE::INST::Parse(char*st)
{
  char *s = skipWhite(st);
  //Parse Mnemonic
  int i=0;
  while(*s && i<15 && *s!='.' && !isspace(*s))
    name[i++] = *(s++);
  name[i] = 0;
  hash = Hash(name);
  if(!i || *s!='.')
    return 0;
  s++;                  //skip '.'
  //Parse Extension
  if(!(s = nextWord(s,desc,15)))
    return 0;
  if(!stricmp(desc,"opt"))
    ext = EXT_OPT;
  else if(!stricmp(desc,"size"))
    ext = EXT_SIZE;
  else if(!stricmp(desc,"type"))
    ext = EXT_TYPE;
  else if(!stricmp(desc,"int"))
    ext = EXT_INT;
  else if(!stricmp(desc,"float"))
    ext = EXT_FLOAT;
  else
    ext = EXT_NONE;
  s = skipWhite(s);
  //Parse ea1
  if(!(s = nextWord(s,desc,31)))
    return 0;
  ea1 = determineEA(desc);
  s = skipWhite(s);
  //Parse ea2
  if(!(s = nextWord(s,desc,31)))
    return 0;
  ea2 = determineEA(desc);
  s = skipWhite(s);
  //Parse ea3
  if(!(s = nextWord(s,desc,31)))
    return 0;
  ea3 = determineEA(desc);
  s = skipWhite(s);
  //Parse Description
  if(!*s || *s!='\"')
    return 0;
  s++;
  i=0;
  while(*s && i<63 && *s!='\"')
    desc[i++] = *(s++);
  desc[i] = 0;
  return 1;
}


INSTABLE::INSTABLE(char *filename) : inst(0), noInst(0), maxInst(1)
{
  FILEIO f;
  if(f.Open(filename)){
    cerr << "ERROR: \"" << filename << "\" not found (Fatal)\n";
    return;
  }
  int  size = f.Size();
  char*data = new char[size+4];
  if(!data){
    cerr << "ERROR: Internal Memory Error (Fatal, Type -1)\n";
    return;
  }
  f.Read(data,1,size);
  data[size]=0;
  int i;
  for(i=0; i<size; i++)
    if(data[i]=='\n')
      maxInst++;
  inst = new INST[maxInst];
  if(!inst){
    cerr << "ERROR: Internal Memory Error (Fatal, Type -2)\n";
    return;
  }
  i = 0;
  while(noInst<maxInst && i<size){
    if(inst[noInst].Parse(data+i))
      noInst++;
    while(i<size && data[i]!='\n' && data[i])
      i++;
    while(i<size && (data[i]=='\n' || data[i]=='\r'))
      i++;
  }
  delete[] data;
  f.Close();
}


//// CLASS ERRORMSG /////////////////////////////////////////////////


ERRORMSG::ERRORMSG(char*filename) : no(0), msg(0), data(0)
{
  FILEIO f;
  if(f.Open(filename)){
    cerr << "WARNING: \"" << filename << "\" not found (Error messages will not be available)\n";
    return;
  }
  int size = f.Size();
  data = new char[size+4];
  if(!data){
    cerr << "WARNING: Error Message buffer not allocated (Error messages will not be available)\n";
    return;
  }
  f.Read(data,1,size);
  data[size]='\n';
  int i;
  for(i=0; i<=size; i++){
    if(data[i]=='\n')
      no++;
    if(data[i]<32)
      data[i] = 0;
  }

  msg = new char*[no];
  if(!msg){
    cerr << "WARNING: Error Message buffer2 not allocated (Error messages will not be available)\n";
    return;
  }
  msg[0]=data;
  int e=1;
  for(i=1; i<size && e<no; i++)
    if(!data[i]){
      while(i<size && !data[i])
        i++;
      msg[e++] = data+i;
    }
  f.Close();
  //for(i=0; i<no; i++) cout << i << ") " << msg[i] << "\n";
}


//// CLASS LABEL ////////////////////////////////////////////////////


void LABEL::Set(char*n,uint32 p)
{
  delete []name;
  name = 0;
  name = new char[ strlen(n)+1 ];
  if(name){
    strcpy(name, n);
    hash = Hash(name);
    pos  = p;
  }
}


//// CLASS TOKEN ////////////////////////////////////////////////////


int TOKEN::validateDirective(PARSER*parser)
{
  int ch = parser->buffer[parser->pos];
  if(!isalpha(ch))
    return PERR_NODIRECTIVE;
  else {
    parser->IncrementBuffer();
    int done=0, spanNextLine=0;
    while(parser->pos < parser->len && !done){
      ch = parser->buffer[parser->pos];
      parser->IncrementBuffer();
      if(ch=='\n'){
        if(spanNextLine)
          spanNextLine--;
        else
          done=1;
      }
      if(ch=='\\')
        spanNextLine=1;
    }
  }
  type = DIRECTIVE;
  return 0;
}


int TOKEN::validateData(PARSER*parser)
{
  char *buf = parser->buffer;
  //Skip Type
  //if(parser->pos<parser->len &&
  type = DATA;
  return 0;
}


int TOKEN::validateDotToken(PARSER*parser,char*key)
{
  int pos = parser->pos;
  parser->IncrementBuffer();
  parser->buffer[pos] = 0;
  cout << "\n\tToken: \"" << key << "\" ";
  if(!strcmp(key,"data") || !strcmp(key,"const")){
    parser->buffer[pos] = '.';
    return validateData(parser);
  }
  else{
  }
  parser->buffer[pos] = '.';
  return 0;
}


int TOKEN::Parse(PARSER*parser)
{
  if(parser){
    if(parser->pos < parser->len){
      int ch = parser->buffer[parser->pos];
      if(ch == '#'){  //Directive?
        token = parser->buffer + parser->pos;
        parser->IncrementBuffer();
        return validateDirective(parser);
      }
      else if(isalpha(ch) || ch=='_'){
        int  p=parser->pos;
        while(parser->pos<parser->len && (isalnum(parser->buffer[parser->pos]) || parser->buffer[parser->pos]=='_'))
          parser->IncrementBuffer();
        int ch = parser->buffer[parser->pos];
        switch(ch)
        {
          case ':':  //Label?
            parser->buffer[parser->pos]=0; cout << "\n\tLabel: ["<<(parser->buffer+p)<<"]"; parser->buffer[parser->pos]=':';
            parser->IncrementBuffer();
            type = LABEL;
            return 0;
          case '.':  //Data? Inst?
            return validateDotToken(parser,parser->buffer+p);
          default:
            if(isspace(ch) || ch==';'){

            }
        }
      }
      else
        return PERR_SYNTAX;
    }
    //parser->IncrementBuffer();
    return 0;
  }
  return PERR_INTERNAL;
}


int TOKEN::Type(PARSER*parser)
{
  if(parser){
    if(parser->pos < parser->len){
      int ch = parser->buffer[parser->pos];
      if(ch == '#'){                             //Directive?
        token = parser->buffer + parser->pos;
        parser->IncrementBuffer();
        return validateDirective(parser);
      }
      else if(ch=='\'' || ch=='{' || ch=='\"'){  //Enclosure
        parser->IncrementBuffer();
        int  stop_ch = ch;
        if(ch == '{')
            stop_ch = '}';
        int  done=0;
        while(parser->pos<parser->len && !done){
          int ch = parser->buffer[parser->pos];
          parser->IncrementBuffer();
          if(ch == '\\')
            parser->IncrementBuffer();
          else if(ch==stop_ch)
            done=1;
        }
      }
      else if(isalpha(ch) || ch=='_'){          //Alpha
        int  p=parser->pos;
        while(parser->pos<parser->len && (isalnum(parser->buffer[parser->pos]) || parser->buffer[parser->pos]=='_'))
          parser->IncrementBuffer();
        int ch = parser->buffer[parser->pos];
        switch(ch)
        {
          case ':':  //Label?
            parser->buffer[parser->pos]=0; cout << "\n\tLabel: ["<<(parser->buffer+p)<<"]"; parser->buffer[parser->pos]=':';
            parser->IncrementBuffer();
            type = LABEL;
            return 0;
          case '.':  //Data? Inst?
            parser->buffer[parser->pos]=0;
            if(!strcmp(parser->buffer+p,"data") || !strcmp(parser->buffer+p,"const"))
              type = DATA;
            else
              type = INST;
            parser->buffer[parser->pos]='.';
            parser->IncrementBuffer();
            return 0;
          default:
            if(ch==';'){
              parser->IncrementBuffer();
              type = INST;
              return 0;
            }
        }
      }
      else {
        while(parser->pos<parser->len && !isspace(parser->buffer[parser->pos]))
          parser->IncrementBuffer();
      }
      //parser->IncrementBuffer();
    }

    return 0;
  }
  return PERR_INTERNAL;
}


//// CLASS PARSER ///////////////////////////////////////////////////


int PARSER::Load(char *filename)
{
  inputfile = filename;
  if(buffer)
    Done();
  FILEIO f;
  if(f.Open(inputfile)){
    cerr << "\nERROR: File could not be opened: " << inputfile << "\n";
    return 1;
  }
  len = f.Size();
  if(len <= 0){
    cerr << "\nERROR: File size zero or invalid: " << inputfile << " (" << len << ")\n";
    return 1;
  }
  buffer = new char[len+4];
  memset(buffer,0,len+4);
  if(!buffer){
    cerr << "\nERROR: Allocating file buffer failed: (" << len << ")\n";
    return 1;
  }
  int readlen = f.Read(buffer,1,len);
  if(len != readlen)
    cerr << "\nWARNING: Could not load the whole source file ("<<readlen<<" of "<<len<<")\n";
  f.Close();
  cout << "\nINFO: Loaded source file \"" << inputfile << "\"\n";
  return 0;
}


int PARSER::parseWhite()
{
  int done=0;
  while(!done && pos<len){
    int ch = buffer[pos];
    if(isspace(ch) || ch==';'){
      //MarkBuffer(pos,'S');
      IncrementBuffer();
    }
    else
      done = 1;
  }
  return 0;
}


int PARSER::parseBlockComment()
{
  while(pos < len){
    int ch = buffer[pos];
    MarkBuffer(pos,' ');
    IncrementBuffer();
    if(ch == '*'){
      ch = buffer[pos];
      MarkBuffer(pos,' ');
      IncrementBuffer();
      if(ch == '/')
        return 0;
    }
    else if(ch == '/'){
      ch = buffer[pos];
      MarkBuffer(pos,' ');
      IncrementBuffer();
      if(ch == '*')
        parseBlockComment();
    }
  }
  return PERR_COMMENTNOTTERM;
}


int PARSER::CommentParse()
{
  ResetBufferPos();
  int res=0;

  while(pos < len){
    if(res = parseWhite())
      return res;
    int ch = buffer[pos];

    if(ch=='/'){        //Comment
      MarkBuffer(pos,' ');
      IncrementBuffer();
      if(pos>=len)
        return PERR_PREMATUREEND;
      ch = buffer[pos];
      if(ch == '/'){
        MarkBuffer(pos,' ');
        IncrementBuffer();
        int done=0;
        while(pos<len && !done){
          ch = buffer[pos];
          if(ch == '\n')
            done=1;
          else
            MarkBuffer(pos,' ');
          IncrementBuffer();
        }
      }
      else if(ch == '*'){
        MarkBuffer(pos,' ');
        IncrementBuffer();
        if(res = parseBlockComment())
          return res;
      }
      else{
        return PERR_SYNTAX;
      }
    }
    else if(ch=='\''){  //Skip Character
      IncrementBuffer();
      ch = buffer[pos];
      IncrementBuffer();
      if(ch == '\\'){
        int done=0;
        while(pos<len && !done){
          ch = buffer[pos];
          IncrementBuffer();
          if(ch == '\'')
            done = 1;
          if(ch == '\n')
            return PERR_CHARTOOLONG;
        }
        if(pos>=len && !done)
         return PERR_PREMATUREEND;
      }
      else {
        ch = buffer[pos];
        IncrementBuffer();
        if(ch != '\'')
          return PERR_CHARTOOLONG;
      }
    }
    else if(ch=='\"'){  //Skip String
      IncrementBuffer();
      int done=0;
      while(pos<len && !done){
        ch = buffer[pos];
        IncrementBuffer();
        if(ch=='\\')
          IncrementBuffer();
        else if(ch=='\n')
          return PERR_STRINGTOOLONG;
        else if(ch=='\"')
          done=1;
      }
      if(pos>=len && !done)
        return PERR_PREMATUREEND;
    }
    else
      IncrementBuffer();
  }

  cout << "\n *PASS1: Parsing Comments...   [DONE]\n";
  return 0;
}


int PARSER::CountParse()
{
  cout << " *PASS2: Count Parse...\n";
  ResetBufferPos();
  maxLabel = maxData = 0;
  int res;

  int nn=0,nd=0,ni=0,nu=0;

  while(pos < len){
    if(res = parseWhite())
      return res;

    TOKEN token;
    //if(res = token.Parse(this))
    if(res = token.Type(this))
      return res;
    switch(token.type)
    {
      case TOKEN::NONE: nn++; break;
      case TOKEN::DIRECTIVE:  nd++; break;
      case TOKEN::INST:  ni++;
        break;
      case TOKEN::LABEL:
        maxLabel++;
        break;
      case TOKEN::DATA:
        maxData++;
        break;
      default:
        nu++;
    }
  }

  cout<<"\n\tSTATISTICS\n\tNone:\t\t"<<nn<<"\n\tDirective:\t"<<nd<<"\n\tInst:\t\t"<<ni;
  cout<<"\n\tLabel:\t\t"<<maxLabel<<"\n\tData:\t\t"<<maxData<<"\n\tUnknown:\t"<<nu<<"\n";
  cout << " *PASS2: Parsing Resource Count...   [DONE]\n";
  return 0;
}


int PARSER::Parse()
{
  if(!buffer || len<=0){
    cerr << "\nERROR: Buffer not ready.\n";
    return 1;
  }
  int res = CommentParse();
  if(res)
    return res;
  if(res=CountParse())
    return res;
  return 0;
}


void PARSER::ReportError(int no)
{
  cout << "ERROR: " << inputfile << '[' << line << "," << col << "]: " << errorMsg[no] << " (Code:" << no << ")\n";
  if(pos>=len){
    cout << "<End of file reached>\n";
    return;
  }
  int start=pos, done=0;
  while(start>0 && !done){
    if(buffer[start]<32 || (pos-start)>40){
      start++;
      done=1;
    }
    else
      start--;
  }
  int end=pos;
  done=0;
  while(end<len && !done){
    if(buffer[end]<32 || (end-start)>78)
      done=1;
    else
      end++;
  }
  FILEIO f;
  if(!f.Open(inputfile)){
    char errLine[100];
    f.Seek(start);
    f.Read(errLine,1,(end-start)+1);
    errLine[(end-start)] = 0;
    cout << errLine << '\n';
    for(int i=start; i<pos; i++)
      cout << ' ';
    cout << "^\n";
    f.Close();
  }
}


void PARSER::Done()
{
  if(buffer)
    delete[] buffer;
  buffer = 0;
  len = 0;
}



