unit RTFtypes;

{ $Id: rtftypes.PAS,v 1.45 2013/04/11 16:46:29 lulin Exp $ }

// $Log: rtftypes.PAS,v $
// Revision 1.45  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.44  2013/04/03 09:34:33  narry
// �� ��������� �����
//
// Revision 1.43  2013/02/06 09:41:56  narry
// ��������� ������� \brdrtbl
//
// Revision 1.42  2013/01/30 11:51:57  narry
// ����������� ����������� ������ ����
//
// Revision 1.41  2013/01/22 12:19:52  narry
// ����������� RTFReader
//
// Revision 1.40  2012/11/09 08:52:29  narry
// ������� ����� � �������� ������ (407750788)
//
// Revision 1.39  2012/06/26 13:56:16  narry
// ������������� ������ �� �������
//
// Revision 1.38  2011/09/21 12:30:06  narry
// ��������� ����� ������ ��� �������������� (285510478)
//
// Revision 1.37  2011/04/15 12:41:27  narry
// �������� �������� (262636436)
//
// Revision 1.36  2011/02/09 11:34:21  narry
// �253657673. ������ �������� �� RTF
//
// Revision 1.35  2009/06/24 11:11:48  narry
// - ������-�������� RTF �� OpenOffice
//
// Revision 1.34  2008/05/12 11:43:40  narry
// - ������ ���������� ��������
// - ��������� ������ ��������
//
// Revision 1.33  2008/04/22 10:09:20  narry
// - ����� ��������� ����� ��������
//
// Revision 1.32  2008/04/10 10:59:13  narry
// - ������ �������� �������� ��� ��������� ������
//
// Revision 1.31  2008/04/09 13:51:15  narry
// - �����������
// - ������ �������� ������� �� (*, �, #)
//
// Revision 1.30  2008/03/14 11:36:55  narry
// - ������ � ���������� ������� �������� ������ ������
//
// Revision 1.29  2006/01/05 15:02:45  narry
// - �����: ������ ������������ �� ����������� ����� (�� ������ ���������)
//
// Revision 1.28  2005/12/06 14:37:35  narry
// - ������: AV ��� ��������� ��������� ������
// - �������: ��������� ������� ������
//
// Revision 1.27  2004/01/21 16:11:41  narry
// - update
//
// Revision 1.26  2004/01/16 10:08:57  narry
// - new: ������������� ��������� ��������
//
// Revision 1.25  2003/05/15 11:45:13  narry
// - add: ��������� ���������
//
// Revision 1.24  2003/04/30 12:42:05  narry
// - add: ��������� rtfTwip
// - change: ������ 1440 �� rtfTwip
//
// Revision 1.23  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.22  2002/07/30 15:58:16  narry
// - new behavior: ��������� Strikeout
//
// Revision 1.21  2002/05/29 14:29:31  narry
// - bug fix, update and new behavior
//
// Revision 1.20  2001/11/22 13:58:43  narry
// - update : ������ ���������� ����� �������
//
// Revision 1.19  2001/09/28 07:11:28  narry
// - bug fix: ���� ������ � ������� ��� ������ �����.
//
// Revision 1.18  2001/04/10 10:54:46  narry
// Update - ��������� ����� ���
//
// Revision 1.17  2001/03/02 11:52:35  narry
// Update for ddHTML_r
//
// Revision 1.16  2000/12/15 15:29:55  law
// - ��������� ��������� Log � Id.
//

{$I ddDefine.inc }

interface

uses
  Classes;

const
  UseParam    = Low(Longint);

Type
  TRTfBool = (boolFalse, boolTrue, boolNotDefined);
  TAnime = (atNone, atLasVegas, atBlnkBkg, atSparkle,
            atBlackAnts, atRedAnts, atShimmer, atNotDefined);

  TddStyleDef = (sdParagraph, sdCharacter, sdSection);

  TUnderline = (utNone, utThick, utDotted, utDash, utDotDash, utDotDotDash,
                utDouble, utWord, utWave, utNotDefined);

  TCharPosition = (cpNone, cpSuperScript, cpSubScript, cpNotDefined);
  TJUST = (justL, justR, justC, justF, justP, justNotDefined);
  TSBK = (sbkNon, sbkCol, sbkEvn, sbkOdd, sbkPg, sbkNotDefined);
  TPGN = (pgDec, pgURom, pgLRom, pgULtr, pgLLtr, pgNotDefined);

  TRDS = (rdsSkip, rdsNorm, rdsFontTable, rdsStyleSheet, rdsColorTable,
           rdsFalt, rdsHeader, rdsFooter, rdsFName, rdsFootnote, rdsPicture,
           rdsPanose,  rdsPictureProp, rdsField, rdsFieldInstruction, rdsFieldResult,
           rdsFormField, rdsFormFieldItem,
           rdsInfo, rdsTitle, rdsAuthor, rdsOperator, rdsCreaTim, rdsRevTim,
           rdsCompany, rdsUpr, rdsParaNum, rdsAnnotation, rdsNone, rdsListText,
           rdsBookmarkStart, rdsBookmarkEnd, rdsParaNumbered, rdsSkipGroup,
           rdsShp, rdsShpInst, rdsShpRslt, rdsShpTxt, rdsListTable, rdsListLevel, rdsLevelText,
           rdsList, rdslistoverride, rdslistoverridetable, rdslistpicture, rdsliststylename,
           rdsListName, rdsLevelNumbers);


          { Rtf Destination State   }
  TRIS = ( risNorm, risBin, risHex );       { Rtf Internal State     }

  TMergeType = (mtNone, mtStart, mtCont);
  TShadingType = (stNone, stHoriz, stVert, stDiag, stCross, stDCross,
                  stDkHor, stDkVert, stDkfDiag, stDkbDiag, stDkCross );
  TStrikeType = (srtNone, srtSingle, srtDouble);
  TCharCapsType  = (ccNone, ccAllCaps, ccSmallCaps, ccNotDefined);
  TContourType   = (ctNone, ctEmbo, ctEngrave, ctNotDefined);
  TACTN = (actnSpec, actnByte, actnWord);

  TPropType = (propNone, propChp, propPap, propSep, propDop, propStyle,
               propRow, propCell, propFrame, propFont, propTAB, propPict,
               propFormField, propLevel, propList, propColorTable);
  TRTFSubject = Integer;

  TddBorderOwner = (boNone, boChar, boPara, boRow, boCell);

  TddBreakType = (breakPage, breakColumn, breakSection);
  TddCellJust  = (cellTop, cellCenter, cellBottom);

  TddBorderRules = (brUnknown, brNone, brBasic, brRows, brCols, brAll);
    
{ What types of properties are there?                          }
  TIPROP = Integer;
const
  ipropNone = 0;
  { Common properties}
  ipropName     = 1;
  ipropNumber   = succ(ipropName);
  ipropHeight   = Succ(ipropNumber);
  ipropWidth    = Succ(ipropHeight);
  ipropTop      = Succ(ipropWidth);
  ipropLeft     = Succ(ipropTop);
  ipropBottom   = Succ(ipropLeft);
  ipropRight    = Succ(ipropBottom);
  ipropColorF   = Succ(ipropRight);
  ipropColorB   = Succ(ipropColorF);
  ipropLang     = Succ(ipropColorB);
  ipropLineType = Succ(ipropLang);       { �������� ������� �� ������ }
  ipropShading  = succ(ipropLineType);
  ipropSbk      = succ(ipropShading);
  ipropPard     = succ(ipropSbk);
  ipropSectd    = succ(ipropPard);
  ipropPlain    = succ(ipropSectd);
  ipropBorderWhere = succ(ipropPlain);   { �������� ������� �� ������ }
  ipropScale    = succ(ipropBorderWhere);
  ipropDefault  = succ(ipropScale); { ����� ���������� � �������� �� ��������� }
  iproPAnsiCharSet  = succ(ipropDefault);
  ipropCodePage  = succ(iproPAnsiCharSet);
  ipropBrdrTbl   = succ(ipropCodePage); // ��� �����


  { Character properties }
  ipropAnime     = 100;
  ipropPos       = Succ(ipropAnime);
  ipropHighlight = Succ(ipropPos);
  ipropBold      = succ(ipropHighlight);
  ipropItalic    = succ(ipropBold);
  ipropUnderline = succ(ipropItalic);    { �������� ������� �� ������ }
  iproPAnsiCharCaps  = succ(ipropUnderline); { �������� ������� �� ������ }
  ipropHidden    = succ(iproPAnsiCharCaps);
  ipropDeleted   = succ(ipropHidden);
  iproPAnsiCharScale = succ(ipropDeleted);
  iproPAnsiCharpos   = succ(iproPAnsiCharScale); { �������� ������� �� ������ }
  ipropContour   = succ(iproPAnsiCharPos);    { �������� ������� �� ������ }
  ipropStriked   = succ(ipropContour);   { �������� ������� �� ������ }
  ipropExpan     = succ(ipropStriked);
  ipropKerningSize = succ(ipropExpan);
  ipropUnicode   = succ(ipropKerningSize);
  ipropStrikeout = succ(ipropUnicode);

  { Section&Document properties }
  ipropCols      = 200;
  ipropLandscape = succ(ipropCols);
  ipropFacingp   = succ(ipropLandscape);
  ipropPgnStart  = succ(ipropFacingp);
  ipropPgnFormat = succ(ipropPgnStart);
  ipropEncoding  = succ(ipropPgnFormat);
  ipropRed       = succ(ipropEncoding);
  ipropGreen     = succ(ipropRed);
  ipropBlue      = succ(ipropGreen);
  ipropDefFont   = succ(ipropBlue);
  ipropDefLang   = succ(ipropDefFont);
  ipropDefTab    = succ(ipropDefLang);
  ipropVersion   = succ(ipropDefTab);
  ipropDay       = succ(ipropVersion);
  ipropMonth     = succ(ipropDay);
  ipropYear      = succ(ipropMonth);
  ipropHour      = succ(ipropYear);
  ipropMin       = succ(ipropHour);
  ipropedmins    = Succ(ipropMin);
  ipropnofpages  = Succ(ipropEdMins);
  ipropnofwords  = Succ(ipropNofPages);
  ipropnofchars  = Succ(ipropNofWords);
  ipropnofcharsws = Succ(ipropnofchars);
  ipropVern      = succ(ipropnofcharsws);
  ipropwidowctrl    = succ(ipropVern);
  ipropftnbj        = succ(ipropWidowCtrl);
  ipropaenddoc      = succ(ipropFtnBj);
  ipropnoxlattoyen  = succ(ipropAEndDoc);

  ipropexpshrtn     = succ(ipropNoxLattoyen);
  ipropnoultrlspc   = succ(ipropExpShrtn);
  ipropdntblnsbdb   = succ(ipropNoUltrLspc);
  ipropnospaceforul = succ(ipropdntblnsbdb);
  iprophyphcaps     = succ(ipropnospaceforul);
  ipropformshade    = succ(iprophyphcaps);
  ipropviewkind     = succ(ipropformshade);
  ipropviewscale    = succ(ipropviewkind);
  ipropviewzk       = succ(ipropviewscale);
  iproppgbrdrhead   = succ(ipropviewzk);
  iproppgbrdrfoot   = succ(iproppgbrdrhead);
  ipropfet          = succ(iproppgbrdrfoot);
  iproplinex        = succ(ipropfet);
  ipropendnhere     = succ(iproplinex);

  ipropBreak        = succ(ipropEndnhere);




  { Paragraph properties }
  ipropFirst          = 300;
  ipropJust           = succ(ipropFirst);{ �������� ������� �� ������ }
  ipropMax            = succ(ipropJust);
  ipropHyph           = succ(ipropMax); { ???? }
  ipropInTable        = succ(ipropHyph);
  ipropKeep           = succ(ipropInTable);
  ipropKeepWNext      = succ(ipropKeep);
  ipropNoLine         = succ(ipropKeepWNext);
  ipropBreakBefore    = succ(ipropNoLine);
  ipropSideBSide      = succ(ipropBreakBefore);
  ipropBetween        = succ(ipropSideBSide);
  ipropLineSpaceExact = succ(ipropBetween);
  ipropTabKind        = succ(ipropLineSpaceExact);
  ipropTabLead        = succ(ipropTabKind);
  ipropTabBar         = succ(ipropTabLead);
  ipropTabSize        = succ(ipropTabBar);
  ipropLS             = succ(ipropTabSize);
  ipropLevel          = succ(ipropLS);
  ipropilvl           = succ(ipropLevel);
  ipropitap           = succ(ipropilvl);


  { table properties }
  ipropMerged         = 400;
  ipropMergedFirst    = succ(ipropMerged);
  ipropVMerged        = succ(ipropMergedFirst);
  ipropVMergeFirst    = succ(ipropVMerged);
  ipropVertAlign      = succ(ipropVMergeFirst);

  { font properties }
  ipropFprq           = 500;
  ipropPanose         = succ(ipropFprq);
  ipropNonTaggedName  = succ(ipropPanose);
  ipropFontname       = succ(ipropNonTaggedName);
  ipropFontFamily     = succ(ipropFontName);

  { style properties }
  ipropParaStyle      = 600;
  iproPAnsiCharStyle      = succ(ipropParaStyle);
  ipropSectStyle      = succ(iproPAnsiCharStyle);
  ipropkeycode        = succ(ipropSectStyle);
  ipropkeys           = succ(ipropKeyCode);
  ipropkey            = succ(ipropKeys);
  ipropadditive       = succ(ipropKey);
  ipropbased          = succ(ipropAdditive);
  ipropnext           = succ(ipropBased);
  ipropautoupd        = succ(ipropNext);
  iproppersonal       = succ(ipropAutoUpd);
  ipropcompose        = succ(ipropPersonal);
  ipropreply          = succ(ipropCompose);

  { Picture properties }
  ipropScaleX         = 700;
  ipropScaleY         = succ(ipropScaleX);
  ipropSkipPicture    = succ(ipropScaleY);
  ipropPictType       = succ(ipropSkipPicture);
  ipropPicCropL       = succ(ipropPictType);
  ipropPicCropR       = succ(ipropPicCropL);
  ipropPicCropB       = succ(ipropPicCropR);
  ipropPicCropT       = succ(ipropPicCropB);

  { FormField properties }
  ipropFFDefRes       = 800;
  ipropFFRes          = succ(ipropFFDefRes);
  ipropFFType         = succ(ipropFFRes);

  { List Level properties}
  iproplevelpicturenosize	 = 1000;
  iproplisthybrid          = 1001;
  iproplistoverridestartat =	1002;
  iproplevelfollow         =	1003;
  iproplevelindent         =	1004;
  ipropleveljc             =	1005;
  ipropleveljcn            =	1006;
  iproplevellegal          =	1007;
  iproplevelnfc            =	1008;
  iproplevelnfcn           =	1009;
  iproplevelnorestart      =	1010;
  iproplevelold            =	1011;
  iproplevelpicture        = 	1012;
  iproplevelprev           =	1013;
  iproplevelprevspace      =	1014;
  iproplevelspace          =  1015;
  iproplevelstartat        = 	1016;
  ipropleveltemplateid     = 	1017;
  iproplistid              =	1018;
  iproplistoverridecount   =	1019;
  iproplistoverrideformat  = 	1020;
  iproplistrestarthdn      =	1021;
  iproplistsimple          = 	1022;
  ipropliststyleid         =	1023;
  iproplisttemplateid      =	1024;

const
  rsNone      = ord(propNone);
  rsDocument  = ord(propDOP);
  rsSection   = ord(propSEP);
  rsParagraph = ord(propPAP);
  rsChar      = ord(propCHP);
  rsRow       = ord(propRow);
  rsCell      = ord(propCell);
  rsFrame     = ord(propFrame);

  rtfTwip     = 1440;

type
  TrtfCharacterSet = (rtfANSI, rtfMac, rtfPC, rtfPCA);
  TFontFamily = (ffNil, ffRoman, ffSwiss, ffModern, ffScript, ffDecor,
                 ffTech, ffBidi, ffNotDefined);
  TFontType   = (ftNil, ftTrueType, ftNotDefined);
  TIPFN = (ipfnBin, ipfnHex, ipfnSkipDest);
  TIDEST = (idestPict, idestSkip );
  TTabKind = (tkLeft, tkRight, tkCentered, tkDecimal, tkNotDefined);
  TTabLead = (tlNone, tlDots, tlMiddleDots, tlHyphens, tlUnderline, tlThickLine, tlEqualSign);

  { RTF parser error codes }
  TRTFErrorCode =(
             ecOK,                     { Everything's fine!  }
             ecNotRTF,
             ecStackUnderflow,         (* Unmatched '}'       *)
             ecStackOverflow,          { Too many '{' -- memory exhausted }
             ecUnmatchedBrace,         { RTF ended during an open group.  }
             ecInvalidHex,             { invalid hex character found in data }
             ecBadTable,               { RTF table (sym or prop) invalid    }
             ecAssertion,              { Assertion failure           }
             ecEndOfFile,              { End of file reached while reading RTF }
             { statuses for RTFWriter }
             ecTableNotOpen,
             ecParaNotOpen,
             ecFileNotOpen,
             ecInvalidPropertyTarget
             );

  TddBorderType = (btNone,
                 btSingleThick,    {\brdrs}
                 btDoubleThick,    {\brdrth}
                 btShadowed,       {\brdrsh}
                 btDouble,         {\brdrdb}
                 btDotted,         {\brdrdot}
                 btDashed,         {\brdrdash}
                 btHairline,       {\brdrhair}
                 btDashSmall,      {\brdrdashsm}
                 btDotDash,        {\brdrdashd}
                 btDotDotDash,     {\brdrdashdd}
                 btTriple,         {\brdrtriple}
                 btThickThinS,     {\brdrtnthsg}
                 btThinThickS,     {\brdrthtnsg}
                 btThinThickThinS, {\brdrtnthtnsg}
                 btThickThinM,     {\brdrtnthmg}
                 btThinThickM,     {\brdrthtnmg}
                 btThinThickThinM, {\brdrtnthtnmg}
                 btThickThinL,     {\brdrtnthlg}
                 btThinThickL,     {\brdrthtnlg}
                 btThinThickThinL, {\brdrtnthtnlg}
                 btWavy,           {\brdrwavy}
                 btWavyDouble,     {\brdrwavydb}
                 btStriped,        {\brdrdashdotstr}
                 btEmboss,         {\brdremboss}
                 btEngrave,        {\brdrengrave}
                 btNotDefined
                 );

  TddBorderWhere = (bwNone, bwTop, bwLeft, bwBottom, bwRight, bwHorizontal,
                  bwVertical, bwBox, bwNotDefined);
const
  fValidMac  = $01;
  fValidDOS  = $02;
  fValidNTFS = $04;
  fValidHPFS = $08;
  fNetwork   = $10;
const
  symbolFootnote = -1;

const
//character set of a font in the font table
 fCharsetANSI              = 0;
 fCharsetDefault           = 1;
 fCharsetSymbol            = 2;
 fCharsetInvalid           = 3;
 fCharsetMac               = 77;
 fCharsetShiftJis          = 128;
 fCharsetHangul            = 129;
 fCharsetJohab             = 130;
 fCharsetGB2312            = 134;
 fCharsetBig5              = 136;
 fCharsetGreek             = 161;
 fCharsetTurkish           = 162;
 fCharsetVietnamese        = 163;
 fCharsetHebrew            = 177;
 fCharsetArabic            = 178;
 fCharsetArabicTraditional = 179;
 fCharsetArabicUser        = 180;
 fCharsetHebrewUser        = 181;
 fCharsetBaltic            = 186;
 fCharsetRussian           = 204;
 fCharsetThai              = 222;
 fCharsetEasternEuropean   = 238;
 fCharsetPC437             = 254;
 fCharsetOEM               = 255;


implementation

end.
