Library JclSIMDViewExpertDLL;
{
-----------------------------------------------------------------------------
     DO NOT EDIT THIS FILE, IT IS GENERATED BY THE PACKAGE GENERATOR
            ALWAYS EDIT THE RELATED XML FILE (JclSIMDViewExpertDLL-L.xml)

     Last generated: 04-03-2011  00:08:42 UTC
-----------------------------------------------------------------------------
}

{$R *.res}
{$ALIGN 8}
{$ASSERTIONS ON}
{$BOOLEVAL OFF}
{$DEBUGINFO OFF}
{$EXTENDEDSYNTAX ON}
{$IMPORTEDDATA ON}
{$IOCHECKS ON}
{$LOCALSYMBOLS OFF}
{$LONGSTRINGS ON}
{$OPENSTRINGS ON}
{$OPTIMIZATION ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$REFERENCEINFO OFF}
{$SAFEDIVIDE OFF}
{$STACKFRAMES OFF}
{$TYPEDADDRESS OFF}
{$VARSTRINGCHECKS ON}
{$WRITEABLECONST ON}
{$MINENUMSIZE 1}
{$IMAGEBASE $58080000}
{$DESCRIPTION 'JCL Debug Window of XMM registers'}
{$LIBSUFFIX '160'}
{$IMPLICITBUILD OFF}

{$DEFINE BCB}
{$DEFINE WIN32}
{$DEFINE CONDITIONALEXPRESSIONS}
{$DEFINE RELEASE}

uses
  ToolsAPI,
  JclSIMDViewForm in '..\..\experts\debug\simdview\JclSIMDViewForm.pas' {JclSIMDViewFrm},
  JclSIMDView in '..\..\experts\debug\simdview\JclSIMDView.pas' ,
  JclSIMDUtils in '..\..\experts\debug\simdview\JclSIMDUtils.pas' ,
  JclSIMDModifyForm in '..\..\experts\debug\simdview\JclSIMDModifyForm.pas' {JclSIMDModifyFrm},
  JclSIMDCpuInfo in '..\..\experts\debug\simdview\JclSIMDCpuInfo.pas' {JclFormCpuInfo}
  ;

exports
  JCLWizardInit name WizardEntryPoint;

end.
