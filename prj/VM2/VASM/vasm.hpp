//*****************************************************************//
//** Description:   eXtropia XSF Codec Virtual Machine           **//
//** First Started: 2002-03-08                                   **//
//** Last Updated:                                               **//
//** Author         Serkan YAZICI, Karl Churchill                **//
//** Copyright:     (C)1998-2002, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//


#ifndef _VASM_HPP
#define _VASM_HPP


#include <xBase.hpp>
#include <xSystem/xResources.hpp>


uint32 Hash(char *text);


class FILEIO {
  FILE *fp;
public:
  FILEIO() : fp(0)                        { }
  int Open(char*name,char*mode="rb")      { return (fp=fopen(name,mode))==0; }  //NONZERO on Error
  int Create(char*name,char*mode="wb")    { return (fp=fopen(name,mode))==0; }  //NONZERO on Error
  int CreateText(char*name)               { return (fp=fopen(name,"w"))==0; }  //NONZERO on Error
  int OpenText(char*name)                 { return (fp=fopen(name,"r"))==0; }  //NONZERO on Error
  static int Exists(char*name)            { FILE*t=fopen(name,"rb"); if(t) { fclose(t); return 1; } return 0; }
  long Valid()                            { return fp!=0; }
  void Seek(long off,int w=SEEK_SET)      { fseek(fp,off,w); }
  long Tell()                             { return ftell(fp); }
  long Size()                             { long s=Tell(); Seek(0,SEEK_END); long r=Tell(); Seek(s); return r; }
  size_t Read(void*d,size_t sz,size_t n)  { return fread(d,sz,n,fp); }
  size_t Write(void*d,size_t sz,size_t n) { return fwrite(d,sz,n,fp); }
  char*ReadText(char*buf,int max)         { return fgets(buf,max,fp); }
  int GetCh()                             { return fgetc(fp); }
  long EndOfFile()                        { return feof(fp); }                  //NONZERO if EOF Reached
  void Flush()                            { fflush(fp); }
  void Close()                            { if(fp) { fclose(fp); fp=0; } }
  ~FILEIO()                               { Close(); }
};


class ERRORMSG {
  char  *data;
  char **msg;
  int    no;
public:
  ERRORMSG(char*filename);
  ~ERRORMSG()             { delete[] data; delete[] msg; }
  char* operator[](int i) { if(i>1 && i<=no) if(msg[i]) return msg[i-1]; return "<undefined>"; }
};


//Mnemonic Extensions
#define EXT_NONE    0
#define EXT_OPT     1
#define EXT_SIZE    2
#define EXT_TYPE    3
#define EXT_INT     4
#define EXT_FLOAT   5

//EA Types
#define EA_NONE     0
#define EA_OPT      1
#define EA_ANY      2
#define EA_DEST     3
#define EA_REGD     4
#define EA_OFF      5

class INSTABLE {

  class INST {
    char   name[16];
    uint32 hash;
    uint8  ext, ea1, ea2, ea3;
    char   desc[64];
    char*skipWhite(char*c)    { while(*c && *c!='\n' && isspace(*c))c++; return c; }
    char*nextWord(char*s,char*word,int max);
    int  determineEA(char *ea);
  public:
     INST()                   {}
    ~INST()                   {}
    int Parse(char*);         //Return 1 If parsed successfully
  } *inst;

  int noInst, maxInst;
public:
  INSTABLE(char *filename);
  ~INSTABLE()                 { delete[] inst; }
  int Loaded() const          { if(inst) return 1; return 0; }
};


class LABEL {
  char   *name;
  uint32  hash;
  uint32  pos;
public:
  LABEL() : name(0), hash(0), pos(0) {}
  ~LABEL()                           { delete []name; }
  int operator==(LABEL&lb) const     { return hash==lb.hash; }
  char* operator()() const           { return name; }
  uint32 Pos() const                 { return pos; }
  void Set(char*name,uint32 pos);
};


class PARSER;

/////// ERROR CODES ////////////
#define PERR_INTERNAL         1
#define PERR_SYNTAX           2
#define PERR_PREMATUREEND     3
#define PERR_CHARTOOLONG      4
#define PERR_STRINGTOOLONG    5
#define PERR_COMMENTNOTTERM   6
#define PERR_NODIRECTIVE      7



class TOKEN {
  int validateDirective(PARSER*);
  int validateDotToken(PARSER*,char*);
  int validateData(PARSER*);
public:
  enum TTYPE { NONE,DIRECTIVE,LABEL,INST,DATA } type;
  char *token;
  int Parse(PARSER*);
  int Type(PARSER*);
  TOKEN() : type(NONE),token(0) {}
};


class PARSER {
  friend class TOKEN;
  uint32 line, col, pos, len;
  char*  buffer;
  uint32 noLabel,noData,maxLabel,maxData;
  LABEL *label;
  char  *inputfile;
private:
  void ResetBufferPos()             { line=col=1; pos=0; }
  void IncrementBuffer()            { pos++; if(pos<len){ if(buffer[pos]=='\n'){ line++; col=0; } else col++; } }
  void MarkBuffer(int p,char c)     { if(buffer[p]!='\r' && buffer[p]!='\n') buffer[p]=c; }
  int parseWhite();
  int parseBlockComment();
private:
  int CommentParse();
  int CountParse();
public:
  int Line() const                  { return line; }
  int Col() const                   { return col; }
  int Position() const              { return pos; }
  char*Buffer()                     { return buffer; }
  int Len()                         { return len; }
  void ReportError(int n);
public:
  PARSER() : buffer(0)              {}
  ~PARSER()                         { Done(); }
  int Load(char *filename);
  int Parse();
  void Done();
};



#endif  /*_VASM_HPP*/

