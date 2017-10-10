/*
 * $Id: PdfName.java,v 1.51 2003/10/01 11:05:41 blowagie Exp $
 * $Name:  $
 *
 * Copyright 1999, 2000, 2001, 2002 Bruno Lowagie
 *
 * The contents of this file are subject to the Mozilla Public License Version 1.1
 * (the "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the License.
 *
 * The Original Code is 'iText, a free JAVA-PDF library'.
 *
 * The Initial Developer of the Original Code is Bruno Lowagie. Portions created by
 * the Initial Developer are Copyright (C) 1999, 2000, 2001, 2002 by Bruno Lowagie.
 * All Rights Reserved.
 * Co-Developer of the code is Paulo Soares. Portions created by the Co-Developer
 * are Copyright (C) 2000, 2001, 2002 by Paulo Soares. All Rights Reserved.
 *
 * Contributor(s): all the names of the contributors are added in the source code
 * where applicable.
 *
 * Alternatively, the contents of this file may be used under the terms of the
 * LGPL license (the "GNU LIBRARY GENERAL PUBLIC LICENSE"), in which case the
 * provisions of LGPL are applicable instead of those above.  If you wish to
 * allow use of your version of this file only under the terms of the LGPL
 * License and not to allow others to use your version of this file under
 * the MPL, indicate your decision by deleting the provisions above and
 * replace them with the notice and other provisions required by the LGPL.
 * If you do not delete the provisions above, a recipient may use your version
 * of this file under either the MPL or the GNU LIBRARY GENERAL PUBLIC LICENSE.
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the MPL as stated above or under the terms of the GNU
 * Library General Public License as published by the Free Software Foundation;
 * either version 2 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Library general Public License for more
 * details.
 *
 * If you didn't download this code from the following link, you should check if
 * you aren't using an obsolete version:
 * http://www.lowagie.com/iText/
 */

package com.lowagie.text.pdf;

/**
 * <CODE>PdfName</CODE> is an object that can be used as a name in a PDF-file.
 * <P>
 * A name, like a string, is a sequence of characters. It must begin with a slash
 * followed by a sequence of ASCII characters in the range 32 through 136 except
 * %, (, ), [, ], &lt;, &gt;, {, }, / and #. Any character except 0x00 may be included
 * in a name by writing its twocharacter hex code, preceded by #. The maximum number
 * of characters in a name is 127.<BR>
 * This object is described in the 'Portable Document Format Reference Manual version 1.3'
 * section 4.5 (page 39-40).
 * <P>
 *
 * @see		PdfObject
 * @see		PdfDictionary
 * @see		BadPdfFormatException
 */

public class PdfName extends PdfObject implements Comparable{
    
    // static membervariables (a variety of standard names used in PDF)
    
    /** A name */
    public static final PdfName A = new PdfName("A");    
    /** A name */
    public static final PdfName AA = new PdfName("AA");
    /** A name */
    public static final PdfName ABSOLUTECALORIMETRIC = new PdfName("AbsoluteColorimetric");
    /** A name */
    public static final PdfName AC = new PdfName("AC");
    /** A name */
    public static final PdfName ACROFORM = new PdfName("AcroForm");
    /** A name */
    public static final PdfName ACTION = new PdfName("Action");
    /** A name */
    public static final PdfName AIS = new PdfName("AIS");
    /** A name */
    public static final PdfName ALTERNATE = new PdfName("Alternate");
    /** A name */
    public static final PdfName ANNOT = new PdfName("Annot");
    /** A name */
    public static final PdfName ANTIALIAS = new PdfName("AntiAlias");
    /** A name */
    public static final PdfName ANNOTS = new PdfName("Annots");
    /** A name */
    public static final PdfName AP = new PdfName("AP");
    /** A name */
    public static final PdfName ASCENT = new PdfName("Ascent");
    /** A name */
    public static final PdfName AS = new PdfName("AS");
    /** A name */
    public static final PdfName ASCII85DECODE = new PdfName("ASCII85Decode");
    /** A name */
    public static final PdfName ASCIIHEXDECODE = new PdfName("ASCIIHexDecode");
    /** A name */
    public static final PdfName AUTHOR = new PdfName("Author");
    /** A name */
    public static final PdfName B = new PdfName("B");
    /** A name */
    public static final PdfName BASEENCODING = new PdfName("BaseEncoding");
    /** A name */
    public static final PdfName BASEFONT = new PdfName("BaseFont");
    /** A name */
    public static final PdfName BBOX = new PdfName("BBox");
    /** A name */
    public static final PdfName BC = new PdfName("BC");
    /** A name */
    public static final PdfName BG = new PdfName("BG");
    /** A name */
    public static final PdfName BITSPERCOMPONENT = new PdfName("BitsPerComponent");
    /** A name */
    public static final PdfName BITSPERSAMPLE = new PdfName("BitsPerSample");
    /** A name */
    public static final PdfName BL = new PdfName("Bl");
    /** A name */
    public static final PdfName BLACKIS1 = new PdfName("BlackIs1");
    /** A name */
    public static final PdfName BLACKPOINT = new PdfName("BlackPoint");
    /** A name */
    public static final PdfName BLINDS = new PdfName("Blinds");
    /** A name */
    public static final PdfName BM = new PdfName("BM");
    /** A name */
    public static final PdfName BORDER = new PdfName("Border");
    /** A name */
    public static final PdfName BOUNDS = new PdfName("Bounds");
    /** A name */
    public static final PdfName BOX = new PdfName("Box");
    /** A name */
    public static final PdfName BS = new PdfName("BS");
    /** A name */
    public static final PdfName BTN = new PdfName("Btn");
    /** A name */
    public static final PdfName BYTERANGE = new PdfName("ByteRange");
    /** A name */
    public static final PdfName C = new PdfName("C");
    /** A name */
    public static final PdfName C0 = new PdfName("C0");
    /** A name */
    public static final PdfName C1 = new PdfName("C1");
    /** A name */
    public static final PdfName CA = new PdfName("CA");
    /** A name */
    public static final PdfName ca = new PdfName("ca");
    /** A name */
    public static final PdfName CALGRAY = new PdfName("CalGray");
    /** A name */
    public static final PdfName CALRGB = new PdfName("CalRGB");
    /** A name */
    public static final PdfName CAPHEIGHT = new PdfName("CapHeight");
    /** A name */
    public static final PdfName CATALOG = new PdfName("Catalog");
    /** A name */
    public static final PdfName CCITTFAXDECODE = new PdfName("CCITTFaxDecode");
    /** A name */
    public static final PdfName CENTERWINDOW = new PdfName("CenterWindow");
    /** A name */
    public static final PdfName CH = new PdfName("Ch");
    /** A name */
    public static final PdfName CIDFONTTYPE0 = new PdfName("CIDFontType0");
    /** A name */
    public static final PdfName CIDFONTTYPE2 = new PdfName("CIDFontType2");
    /** A name */
    public static final PdfName CIDSYSTEMINFO = new PdfName("CIDSystemInfo");
    /** A name */
    public static final PdfName CIDTOGIDMAP = new PdfName("CIDToGIDMap");
    /** A name */
    public static final PdfName CIRCLE = new PdfName("Circle");
    /** A name */
    public static final PdfName CO = new PdfName("CO");
    /** A name */
    public static final PdfName COLORS = new PdfName("Colors");
    /** A name */
    public static final PdfName COLORSPACE = new PdfName("ColorSpace");
    /** A name */
    public static final PdfName COLUMNS = new PdfName("Columns");
    /** A name */
    public static final PdfName CONTENT = new PdfName("Content");
    /** A name */
    public static final PdfName CONTENTS = new PdfName("Contents");
    /** A name */
    public static final PdfName COORDS = new PdfName("Coords");
    /** A name */
    public static final PdfName COUNT = new PdfName("Count");
    /** A name of a base 14 type 1 font */
    public static final PdfName COURIER = new PdfName("Courier");
    /** A name of a base 14 type 1 font */
    public static final PdfName COURIER_BOLD = new PdfName("Courier-Bold");
    /** A name of a base 14 type 1 font */
    public static final PdfName COURIER_OBLIQUE = new PdfName("Courier-Oblique");
    /** A name of a base 14 type 1 font */
    public static final PdfName COURIER_BOLDOBLIQUE = new PdfName("Courier-BoldOblique");
    /** A name */
    public static final PdfName CREATIONDATE = new PdfName("CreationDate");
    /** A name */
    public static final PdfName CREATOR = new PdfName("Creator");
    /** A name */
    public static final PdfName CROPBOX = new PdfName("CropBox");
    /** A name */
    public static final PdfName CS = new PdfName("CS");
    /** A name */
    public static final PdfName D = new PdfName("D");
    /** A name */
    public static final PdfName DA = new PdfName("DA");
    /** A name */
    public static final PdfName DC = new PdfName("DC");
    /** A name */
    public static final PdfName DCTDECODE = new PdfName("DCTDecode");
    /** A name */
    public static final PdfName DESCENDANTFONTS = new PdfName("DescendantFonts");
    /** A name */
    public static final PdfName DESCENT = new PdfName("Descent");
    /** A name */
    public static final PdfName DECODE = new PdfName("Decode");
    /** A name */
    public static final PdfName DECODEPARMS = new PdfName("DecodeParms");
    /** A name */
    public static final PdfName DEST = new PdfName("Dest");
    /** A name */
    public static final PdfName DESTS = new PdfName("Dests");
    /** A name */
    public static final PdfName DEVICEGRAY = new PdfName("DeviceGray");
    /** A name */
    public static final PdfName DEVICERGB = new PdfName("DeviceRGB");
    /** A name */
    public static final PdfName DEVICECMYK = new PdfName("DeviceCMYK");
    /** A name */
    public static final PdfName DI = new PdfName("Di");
    /** A name */
    public static final PdfName DIFFERENCES = new PdfName("Differences");
    /** A name */
    public static final PdfName DISSOLVE = new PdfName("Dissolve");
    /** A name */
    public static final PdfName DIRECTION = new PdfName("Direction");
    /** A name */
    public static final PdfName DM = new PdfName("Dm");
    /** A name */
    public static final PdfName DOMAIN = new PdfName("Domain");
    /** A name */
    public static final PdfName DP = new PdfName("DP");
    /** A name */
    public static final PdfName DR = new PdfName("DR");
    /** A name */
    public static final PdfName DS = new PdfName("DS");
    /** A name */
    public static final PdfName DUR = new PdfName("Dur");
    /** A name */
    public static final PdfName DV = new PdfName("DV");
    /** A name */
    public static final PdfName DW = new PdfName("DW");
    /** A name */
    public static final PdfName E = new PdfName("E");
    /** A name */
    public static final PdfName EARLYCHANGE = new PdfName("EarlyChange");
    /** A name */
    public static final PdfName EF = new PdfName("EF");
    /** A name */
    public static final PdfName EMBEDDEDFILE = new PdfName("EmbeddedFile");
    /** A name */
    public static final PdfName ENCODE = new PdfName("Encode");
    /** A name */
    public static final PdfName ENCODEDBYTEALIGN = new PdfName("EncodedByteAlign");
    /** A name */
    public static final PdfName ENCODING = new PdfName("Encoding");
    /** A name */
    public static final PdfName ENCRYPT = new PdfName("Encrypt");
    /** A name */
    public static final PdfName ENDOFBLOCK = new PdfName("EndOfBlock");
    /** A name */
    public static final PdfName ENDOFLINE = new PdfName("EndOfLine");
    /** A name */
    public static final PdfName EXTEND = new PdfName("Extend");
    /** A name */
    public static final PdfName EXTGSTATE = new PdfName("ExtGState");
    /** A name */
    public static final PdfName F = new PdfName("F");
    /** A name */
    public static final PdfName FDECODEPARMS = new PdfName("FDecodeParms");
    /** A name */
    public static final PdfName FDF = new PdfName("FDF");
    /** A name */
    public static final PdfName FF = new PdfName("Ff");
    /** A name */
    public static final PdfName FFILTER = new PdfName("FFilter");
    /** A name */
    public static final PdfName FIELDS = new PdfName("Fields");
    /** A name */
    public static final PdfName FILEATTACHMENT = new PdfName("FileAttachment");
    /** A name */
    public static final PdfName FILESPEC = new PdfName("Filespec");
    /** A name */
    public static final PdfName FILTER = new PdfName("Filter");
    /** A name */
    public static final PdfName FIRST = new PdfName("First");
    /** A name */
    public static final PdfName FIRSTCHAR = new PdfName("FirstChar");
    /** A name */
    public static final PdfName FIRSTPAGE = new PdfName("FirstPage");
    /** A name */
    public static final PdfName FIT = new PdfName("Fit");
    /** A name */
    public static final PdfName FITH = new PdfName("FitH");
    /** A name */
    public static final PdfName FITV = new PdfName("FitV");
    /** A name */
    public static final PdfName FITR = new PdfName("FitR");
    /** A name */
    public static final PdfName FITB = new PdfName("FitB");
    /** A name */
    public static final PdfName FITBH = new PdfName("FitBH");
    /** A name */
    public static final PdfName FITBV = new PdfName("FitBV");
    /** A name */
    public static final PdfName FITWINDOW = new PdfName("FitWindow");
    /** A name */
    public static final PdfName FLAGS = new PdfName("Flags");
    /** A name */
    public static final PdfName FLATEDECODE = new PdfName("FlateDecode");
    /** A name */
    public static final PdfName FO = new PdfName("Fo");
    /** A name */
    public static final PdfName FONT = new PdfName("Font");
    /** A name */
    public static final PdfName FONTBBOX = new PdfName("FontBBox");
    /** A name */
    public static final PdfName FONTDESCRIPTOR = new PdfName("FontDescriptor");
    /** A name */
    public static final PdfName FONTFILE = new PdfName("FontFile");
    /** A name */
    public static final PdfName FONTFILE2 = new PdfName("FontFile2");
    /** A name */
    public static final PdfName FONTFILE3 = new PdfName("FontFile3");
    /** A name */
    public static final PdfName FONTNAME = new PdfName("FontName");
    /** A name */
    public static final PdfName FORM = new PdfName("Form");
    /** A name */
    public static final PdfName FORMTYPE = new PdfName("FormType");
    /** A name */
    public static final PdfName FREETEXT = new PdfName("FreeText");
    /** A name */
    public static final PdfName FS = new PdfName("FS");
    /** A name */
    public static final PdfName FT = new PdfName("FT");
    /** A name */
    public static final PdfName FULLSCREEN = new PdfName("FullScreen");
    /** A name */
    public static final PdfName FUNCTION = new PdfName("Function");
    /** A name */
    public static final PdfName FUNCTIONS = new PdfName("Functions");
    /** A name */
    public static final PdfName FUNCTIONTYPE = new PdfName("FunctionType");
    /** A name of an attribute. */
    public static final PdfName GAMMA = new PdfName("Gamma");
    /** A name of an attribute. */
    public static final PdfName GLITTER = new PdfName("Glitter");
    /** A name of an attribute. */
    public static final PdfName GOTO = new PdfName("GoTo");
    /** A name of an attribute. */
    public static final PdfName GOTOR = new PdfName("GoToR");
    /** A name of an attribute. */
    public static final PdfName GROUP = new PdfName("Group");
    /** A name of an attribute. */
    public static final PdfName H = new PdfName("H");
    /** A name of an attribute. */
    public static final PdfName HEIGHT = new PdfName("Height");
    /** A name of a base 14 type 1 font */
    public static final PdfName HELVETICA = new PdfName("Helvetica");
    /** A name of a base 14 type 1 font */
    public static final PdfName HELVETICA_BOLD = new PdfName("Helvetica-Bold");
    /** This is a static PdfName PdfName of a base 14 type 1 font */
    public static final PdfName HELVETICA_OBLIQUE = new PdfName("Helvetica-Oblique");
    /** This is a static PdfName PdfName of a base 14 type 1 font */
    public static final PdfName HELVETICA_BOLDOBLIQUE = new PdfName("Helvetica-BoldOblique");
    /** A name */
    public static final PdfName HID = new PdfName("Hid");
    /** A name */
    public static final PdfName HIDE = new PdfName("Hide");
    /** A name */
    public static final PdfName HIDEMENUBAR = new PdfName("HideMenubar");
    /** A name */
    public static final PdfName HIDETOOLBAR = new PdfName("HideToolbar");
    /** A name */
    public static final PdfName HIDEWINDOWUI = new PdfName("HideWindowUI");
    /** A name */
    public static final PdfName HIGHLIGHT = new PdfName("Highlight");
    /** A name */
    public static final PdfName I = new PdfName("I");
    /** A name */
    public static final PdfName ICCBASED = new PdfName("ICCBased");
    /** A name */
    public static final PdfName ID = new PdfName("ID");
    /** A name */
    public static final PdfName IDENTITY = new PdfName("Identity");
    /** A name */
    public static final PdfName IF = new PdfName("IF");
    /** A name */
    public static final PdfName IMAGE = new PdfName("Image");
    /** A name */
    public static final PdfName IMAGEB = new PdfName("ImageB");
    /** A name */
    public static final PdfName IMAGEC = new PdfName("ImageC");
    /** A name */
    public static final PdfName IMAGEI = new PdfName("ImageI");
    /** A name */
    public static final PdfName IMAGEMASK = new PdfName("ImageMask");
    /** A name */
    public static final PdfName INDEXED = new PdfName("Indexed");
    /** A name */
    public static final PdfName INFO = new PdfName("Info");
    /** A name */
    public static final PdfName INK = new PdfName("Ink");
    /** A name */
    public static final PdfName INKLIST = new PdfName("InkList");
    /** A name */
    public static final PdfName IMPORTDATA = new PdfName("ImportData");
    /** A name */
    public static final PdfName INTENT = new PdfName("Intent");
    /** A name */
    public static final PdfName INTERPOLATE = new PdfName("Interpolate");
    /** A name */
    public static final PdfName ISMAP = new PdfName("IsMap");
    /** A name */
    public static final PdfName ITALICANGLE = new PdfName("ItalicAngle");
    /** A name */
    public static final PdfName IX = new PdfName("IX");
    /** A name */
    public static final PdfName JAVASCRIPT = new PdfName("JavaScript");
    /** A name */
    public static final PdfName JS = new PdfName("JS");
    /** A name */
    public static final PdfName K = new PdfName("K");
    /** A name */
    public static final PdfName KEYWORDS = new PdfName("Keywords");
    /** A name */
    public static final PdfName KIDS = new PdfName("Kids");
    /** A name */
    public static final PdfName L = new PdfName("L");
    /** A name */
    public static final PdfName L2R = new PdfName("L2R");
    /** A name */
    public static final PdfName LAST = new PdfName("Last");
    /** A name */
    public static final PdfName LASTCHAR = new PdfName("LastChar");
    /** A name */
    public static final PdfName LASTPAGE = new PdfName("LastPage");
    /** A name */
    public static final PdfName LAUNCH = new PdfName("Launch");
    /** A name */
    public static final PdfName LENGTH = new PdfName("Length");
    /** A name */
    public static final PdfName LENGTH1 = new PdfName("Length1");
    /** A name */
    public static final PdfName LIMITS = new PdfName("Limits");
    /** A name */
    public static final PdfName LINE = new PdfName("Line");
    /** A name */
    public static final PdfName LINK = new PdfName("Link");
    /** A name */
    public static final PdfName LOCATION = new PdfName("Location");
    /** A name */
    public static final PdfName LZWDECODE = new PdfName("LZWDecode");
    /** A name */
    public static final PdfName M = new PdfName("M");
    /** A name */
    public static final PdfName MATRIX = new PdfName("Matrix");
    /** A name of an encoding */
    public static final PdfName MAC_EXPERT_ENCODING = new PdfName("MacExpertEncoding");
    /** A name of an encoding */
    public static final PdfName MAC_ROMAN_ENCODING = new PdfName("MacRomanEncoding");
    /** A name */
    public static final PdfName MASK = new PdfName("Mask");
    /** A name */
    public static final PdfName MAXLEN = new PdfName("MaxLen");
    /** A name */
    public static final PdfName MEDIABOX = new PdfName("MediaBox");
    /** A name */
    public static final PdfName METADATA = new PdfName("Metadata");
    /** A name */
    public static final PdfName MK = new PdfName("MK");
    /** A name */
    public static final PdfName MMTYPE1 = new PdfName("MMType1");
    /** A name */
    public static final PdfName MODDATE = new PdfName("ModDate");
    /** A name */
    public static final PdfName N = new PdfName("N");
    /** A name */
    public static final PdfName NAME = new PdfName("Name");
    /** A name */
    public static final PdfName NAMED = new PdfName("Named");
    /** A name */
    public static final PdfName NAMES = new PdfName("Names");
    /** A name */
    public static final PdfName NEEDAPPEARANCES = new PdfName("NeedAppearances");
    /** A name */
    public static final PdfName NEXT = new PdfName("Next");
    /** A name */
    public static final PdfName NEXTPAGE = new PdfName("NextPage");
    /** A name */
    public static final PdfName NONFULLSCREENPAGEMODE = new PdfName("NonFullScreenPageMode");
    /** A name */
    public static final PdfName NUMS = new PdfName("Nums");
    /** A name */
    public static final PdfName O = new PdfName("O");
    /** A name */
    public static final PdfName OFF = new PdfName("Off");
    /** A name */
    public static final PdfName ONECOLUMN = new PdfName("OneColumn");
    /** A name */
    public static final PdfName OPEN = new PdfName("Open");
    /** A name */
    public static final PdfName OPENACTION = new PdfName("OpenAction");
    /** A name */
    public static final PdfName OP = new PdfName("OP");
    /** A name */
    public static final PdfName op = new PdfName("op");
    /** A name */
    public static final PdfName OPM = new PdfName("OPM");
    /** A name */
    public static final PdfName OPT = new PdfName("Opt");
    /** A name */
    public static final PdfName ORDER = new PdfName("Order");
    /** A name */
    public static final PdfName ORDERING = new PdfName("Ordering");
    /** A name */
    public static final PdfName OUTLINES = new PdfName("Outlines");
    /** A name */
    public static final PdfName P = new PdfName("P");
    /** A name */
    public static final PdfName PAGE = new PdfName("Page");
    /** A name */
    public static final PdfName PAGELABELS = new PdfName("PageLabels");
    /** A name */
    public static final PdfName PAGELAYOUT = new PdfName("PageLayout");
    /** A name */
    public static final PdfName PAGEMODE = new PdfName("PageMode");
    /** A name */
    public static final PdfName PAGES = new PdfName("Pages");
    /** A name */
    public static final PdfName PAINTTYPE = new PdfName("PaintType");
    /** A name */
    public static final PdfName PANOSE = new PdfName("Panose");
    /** A name */
    public static final PdfName PARENT = new PdfName("Parent");
    /** A name */
    public static final PdfName PATTERN = new PdfName("Pattern");
    /** A name */
    public static final PdfName PATTERNTYPE = new PdfName("PatternType");
    /** A name */
    public static final PdfName PDF = new PdfName("PDF");
    /** A name */
    public static final PdfName PERCEPTUAL = new PdfName("Perceptual");
    /** A name */
    public static final PdfName POPUP = new PdfName("Popup");
    /** A name */
    public static final PdfName PREDICTOR = new PdfName("Predictor");
    /** A name */
    public static final PdfName PREV = new PdfName("Prev");
    /** A name */
    public static final PdfName PREVPAGE = new PdfName("PrevPage");
    /** A name */
    public static final PdfName PROCSET = new PdfName("ProcSet");
    /** A name */
    public static final PdfName PRODUCER = new PdfName("Producer");
    /** A name */
    public static final PdfName PROPERTIES = new PdfName("Properties");
    /** A name */
    public static final PdfName Q = new PdfName("Q");
    /** A name */
    public static final PdfName QUADPOINTS = new PdfName("QuadPoints");
    /** A name */
    public static final PdfName R = new PdfName("R");
    /** A name */
    public static final PdfName R2L = new PdfName("R2L");
    /** A name */
    public static final PdfName RANGE = new PdfName("Range");
    /** A name */
    public static final PdfName RC = new PdfName("RC");
    /** A name */
    public static final PdfName REASON = new PdfName("Reason");
    /** A name */
    public static final PdfName RECT = new PdfName("Rect");
    /** A name */
    public static final PdfName REGISTRY = new PdfName("Registry");
    /** A name */
    public static final PdfName RELATIVECALORIMETRIC = new PdfName("RelativeColorimetric");
    /** A name */
    public static final PdfName RESETFORM = new PdfName("ResetForm");
    /** A name */
    public static final PdfName RESOURCES = new PdfName("Resources");
    /** A name */
    public static final PdfName RI = new PdfName("RI");
    /** A name */
    public static final PdfName ROOT = new PdfName("Root");
    /** A name */
    public static final PdfName ROTATE = new PdfName("Rotate");
    /** A name */
    public static final PdfName ROWS = new PdfName("Rows");
    /** A name */
    public static final PdfName RUNLENGTHDECODE = new PdfName("RunLengthDecode");
    /** A name */
    public static final PdfName S = new PdfName("S");
    /** A name */
    public static final PdfName SATURATION = new PdfName("Saturation");
    /** A name */
    public static final PdfName SEPARATION = new PdfName("Separation");
    /** A name */
    public static final PdfName SHADING = new PdfName("Shading");
    /** A name */
    public static final PdfName SHADINGTYPE = new PdfName("ShadingType");
    /** A name */
    public static final PdfName SIG = new PdfName("Sig");
    /** A name */
    public static final PdfName SIGFLAGS = new PdfName("SigFlags");
    /** A name */
    public static final PdfName SINGLEPAGE = new PdfName("SinglePage");
    /** A name */
    public static final PdfName SIZE = new PdfName("Size");
    /** A name */
    public static final PdfName SMASK = new PdfName("SMask");
    /** A name */
    public static final PdfName SPLIT = new PdfName("Split");
    /** A name */
    public static final PdfName SQUARE = new PdfName("Square");
    /** A name */
    public static final PdfName ST = new PdfName("St");
    /** A name */
    public static final PdfName STAMP = new PdfName("Stamp");
    /** A name */
    public static final PdfName STANDARD = new PdfName("Standard");
    /** A name */
    public static final PdfName STRIKEOUT = new PdfName("StrikeOut");
    /** A name */
    public static final PdfName STYLE = new PdfName("Style");
    /** A name */
    public static final PdfName STEMV = new PdfName("StemV");
    /** A name */
    public static final PdfName SUBFILTER = new PdfName("SubFilter");
    /** A name */
    public static final PdfName SUBJECT = new PdfName("Subject");
    /** A name */
    public static final PdfName SUBMITFORM = new PdfName("SubmitForm");
    /** A name */
    public static final PdfName SUBTYPE = new PdfName("Subtype");
    /** A name */
    public static final PdfName SUPPLEMENT = new PdfName("Supplement");
    /** A name */
    public static final PdfName SW = new PdfName("SW");
    /** A name of a base 14 type 1 font */
    public static final PdfName SYMBOL = new PdfName("Symbol");
    /** A name */
    public static final PdfName T = new PdfName("T");
    /** A name */
    public static final PdfName TEXT = new PdfName("Text");
    /** A name */
    public static final PdfName THUMB = new PdfName("Thumb");
    /** A name */
    public static final PdfName THREADS = new PdfName("Threads");
    /** A name */
    public static final PdfName TI = new PdfName("TI");
    /** A name */
    public static final PdfName TILINGTYPE = new PdfName("TilingType");
    /** A name of a base 14 type 1 font */
    public static final PdfName TIMES_ROMAN = new PdfName("Times-Roman");
    /** A name of a base 14 type 1 font */
    public static final PdfName TIMES_BOLD = new PdfName("Times-Bold");
    /** A name of a base 14 type 1 font */
    public static final PdfName TIMES_ITALIC = new PdfName("Times-Italic");
    /** A name of a base 14 type 1 font */
    public static final PdfName TIMES_BOLDITALIC = new PdfName("Times-BoldItalic");
    /** A name */
    public static final PdfName TITLE = new PdfName("Title");
    /** A name */
    public static final PdfName TK = new PdfName("TK");
    /** A name */
    public static final PdfName TM = new PdfName("TM");
    /** A name */
    public static final PdfName TOUNICODE = new PdfName("ToUnicode");
    /** A name */
    public static final PdfName TP = new PdfName("TP");
    /** A name */
    public static final PdfName TRANS = new PdfName("Trans");
    /** A name */
    public static final PdfName TRANSPARENCY = new PdfName("Transparency");
    /** A name */
    public static final PdfName TRAPPED = new PdfName("Trapped");
    /** A name */
    public static final PdfName TRUETYPE = new PdfName("TrueType");
    /** A name */
    public static final PdfName TU = new PdfName("TU");
    /** A name */
    public static final PdfName TWOCOLUMNLEFT = new PdfName("TwoColumnLeft");
    /** A name */
    public static final PdfName TWOCOLUMNRIGHT = new PdfName("TwoColumnRight");
    /** A name */
    public static final PdfName TX = new PdfName("Tx");
    /** A name */
    public static final PdfName TYPE = new PdfName("Type");
    /** A name */
    public static final PdfName TYPE0 = new PdfName("Type0");
    /** A name */
    public static final PdfName TYPE1 = new PdfName("Type1");
    /** A name of an attribute. */
    public static final PdfName U = new PdfName("U");
    /** A name of an attribute. */
    public static final PdfName UNDERLINE = new PdfName("Underline");
    /** A name */
    public static final PdfName URI = new PdfName("URI");
    /** A name */
    public static final PdfName URL = new PdfName("URL");
    /** A name */
    public static final PdfName USENONE = new PdfName("UseNone");
    /** A name */
    public static final PdfName USEOUTLINES = new PdfName("UseOutlines");
    /** A name */
    public static final PdfName USETHUMBS = new PdfName("UseThumbs");
    /** A name */
    public static final PdfName V = new PdfName("V");
    /** A name */
    public static final PdfName VIEWERPREFERENCES = new PdfName("ViewerPreferences");
    /** A name of an attribute. */
    public static final PdfName W = new PdfName("W");
    /** A name of an attribute. */
    public static final PdfName W2 = new PdfName("W2");
    /** A name of an attribute. */
    public static final PdfName WIDGET = new PdfName("Widget");
    /** A name of an attribute. */
    public static final PdfName WIDTH = new PdfName("Width");
    /** A name */
    public static final PdfName WIDTHS = new PdfName("Widths");
    /** A name of an encoding */
    public static final PdfName WIN = new PdfName("Win");
    /** A name of an encoding */
    public static final PdfName WIN_ANSI_ENCODING = new PdfName("WinAnsiEncoding");
    /** A name of an encoding */
    public static final PdfName WIPE = new PdfName("Wipe");
    /** A name */
    public static final PdfName WHITEPOINT = new PdfName("WhitePoint");
    /** A name */
    public static final PdfName WP = new PdfName("WP");
    /** A name of an encoding */
    public static final PdfName WS = new PdfName("WS");
    /** A name */
    public static final PdfName X = new PdfName("X");
    /** A name */
    public static final PdfName XOBJECT = new PdfName("XObject");
    /** A name */
    public static final PdfName XSTEP = new PdfName("XStep");
    /** A name */
    public static final PdfName XYZ = new PdfName("XYZ");
    /** A name */
    public static final PdfName YSTEP = new PdfName("YStep");
    /** A name of a base 14 type 1 font */
    public static final PdfName ZAPFDINGBATS = new PdfName("ZapfDingbats");
    
    private int hash = 0;
    
    // constructors
    
    /**
     * Constructs a <CODE>PdfName</CODE>-object.
     *
     * @param		name		the new Name.
     */
    
    public PdfName(String name) {
        super(PdfObject.NAME);
        // The minimum number of characters in a name is 0, the maximum is 127 (the '/' not included)
        int length = name.length();
        if (length > 127) {
            throw new IllegalArgumentException("The name is too long (" + bytes.length + " characters).");
        }
        // The name has to be checked for illegal characters
        // every special character has to be substituted
        ByteBuffer pdfName = new ByteBuffer(length + 20);
        pdfName.append('/');
        char character;
        char chars[] = name.toCharArray();
        // loop over all the characters
        for (int index = 0; index < length; index++) {
            character = (char)(chars[index] & 0xff);
            // special characters are escaped (reference manual p.39)
            switch (character) {
                case ' ':
                case '%':
                case '(':
                case ')':
                case '<':
                case '>':
                case '[':
                case ']':
                case '{':
                case '}':
                case '/':
                case '#':
                    pdfName.append('#');
                    pdfName.append(Integer.toString((int) character, 16));
                    break;
                default:
                    if (character > 126 || character < 32) {
                        pdfName.append('#');
                        if (character < 16)
                            pdfName.append('0');
                        pdfName.append(Integer.toString((int) character, 16));
                    }
                    else
                        pdfName.append(character);
                    break;
            }
        }
        bytes = pdfName.toByteArray();
    }
    
    public PdfName(byte bytes[]) {
        super(PdfObject.NAME, bytes);
    }
    // methods
    
    /**
     * Compares this object with the specified object for order.  Returns a
     * negative integer, zero, or a positive integer as this object is less
     * than, equal to, or greater than the specified object.<p>
     *
     *
     * @param   object the Object to be compared.
     * @return  a negative integer, zero, or a positive integer as this object
     *		is less than, equal to, or greater than the specified object.
     *
     * @throws ClassCastException if the specified object's type prevents it
     *         from being compared to this Object.
     */
    public int compareTo(Object object) {
        PdfName name = (PdfName) object;
        
        byte myBytes[] = bytes;
        byte objBytes[] = name.bytes;
        int len = Math.min(myBytes.length, objBytes.length);
        for(int i=0; i<len; i++) {
            if(myBytes[i] > objBytes[i])
                return 1;
            
            if(myBytes[i] < objBytes[i])
                return -1;
        }
        if (myBytes.length < objBytes.length)
            return -1;
        if (myBytes.length > objBytes.length)
            return 1;
        return 0;
    }
    
    /**
     * Indicates whether some other object is "equal to" this one.
     *
     * @param   obj   the reference object with which to compare.
     * @return  <code>true</code> if this object is the same as the obj
     *          argument; <code>false</code> otherwise.
     */
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj instanceof PdfName)
            return compareTo(obj) == 0;
        return false;
    }
    
    /**
     * Returns a hash code value for the object. This method is
     * supported for the benefit of hashtables such as those provided by
     * <code>java.util.Hashtable</code>.
     *
     * @return  a hash code value for this object.
     */
    public int hashCode() {
        int h = hash;
        if (h == 0) {
            int ptr = 0;
            int len = bytes.length;
            
            for (int i = 0; i < len; i++)
                h = 31*h + (bytes[ptr++] & 0xff);
            hash = h;
        }
        return h;
    }
    
    /** Decodes an escaped name in the form "/AB#20CD" into "AB CD".
     * @param name the name to decode
     * @return the decoded name
     */
    public static String decodeName(String name) {
        StringBuffer buf = new StringBuffer();
        try {
            int len = name.length();
            for (int k = 1; k < len; ++k) {
                char c = name.charAt(k);
                if (c == '#') {
                    c = (char)((PRTokeniser.getHex(name.charAt(k + 1)) << 4) + PRTokeniser.getHex(name.charAt(k + 2)));
                    k += 2;
                }
                buf.append(c);
            }
        }
        catch (IndexOutOfBoundsException e) {
            // empty on purpose
        }
        return buf.toString();
    }
}
