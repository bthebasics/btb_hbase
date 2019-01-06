## How to create eBooks from PDF 

link : https://www.mobileread.com/forums/showthread.php?t=160755

Pdf is one of the most common format around but not very useful or user-friendly for ebook readers. For better reading experience on our reading devices, at some point, we need to convert pdf to another more conventional formats such as epub or mobi. 

The main issues with pdf to epub/mobi conversions:
1. Page numbers
2. Ruptured or half-cut paragraphs
3. Stylistic issues (bold, italic)
4. Font-declarations


I have been dealing with pdf conversions for quite sometime, and tried several commercial and free converters and other workarounds, I will to try to share my experience with you, while doing so, I will go from easiest method to more complicated ones to implement.

It will be a long list of methods, I will add more in the future. But remember, every pdf creator has its own way of coding the text, so every pdf files will be slightly different than the other.

If you have better methods or more convenient ways, please share with us, so we can come up one, all in one thread.



#### Using Mobipocket Creator and Calibre

This method will remove page numbers and join ruptured paragraphs. We will use Mobipocket to remove page numbers and join half-cut paragraphs and Calibre to convert html file to epub/mobi or other formats

1. Install mobipocket creator and run it. 

2. On the home screen, "Under Import From Existing File", click "Import Adobe PDF".

3. Choose file from a directory, define publication folder, language and encoding.

4. Click Import
  If your pdf has legitimate repeating pattern, such as page number, it will be removed and half-cut paragraphs on different pages will be joined. By legitimate, we mean: numbers appear on the same spot throughout the book as you expect in a printed book.

5. You can go ahead and use Mobipocket creator to create prc file and convert this file to other formats via calibre which I don't recommend. But if you want so, rest is pretty straight forward. One thing you need to know, you can study html file and define tagname, attribute and value to make multilevel TOC, just like you do in calibre. 

6. Go to your publication folder, default publication folder is under My documents/My Publications. You will find your book in a separate folder under publication folder. You will see different formats of your book in this folder. 

7. Open html file with an html editor. You can use free editors, notepad or wordpad to correct minor mistakes or clean unnecessary sections. Study title and subtitle patterns. For examples titles can be wrapped in H1 tags and subtitles in h2, h3, with proper attributes and values which can be used to make multilevel table of contens (TOC).

8. Once you fixed html file, you can drag and drop it on Calibre, in which you can define styles, TOC etc.

Edit: 
In some cases, cropping pdf before dropping it into Mobipocket creator yields better results with Mobipocket creator. There is a simple and free software called Briss to crop pdf files. Portable version is also available.
1. Run Briss
2. Load the file
3. Cancel the warning, if you don't know what to do.
4. On the cropping screen, all the odd pages will be superimposed into a singe look, so do the even pages, and blue rectangle with small dark squares at the corners will appear on each pages. Drag these squares to set the margins of the cropping for better result. You can preview it by clicking action on the menu bar >> Preview
5. Once you set the margins, click action >> Crop PDF
  Briss is not stable enough, sometimes gives error and may not let you crop but you can always preview it. So saving previewed pdf will also work.

#### Using Adobe PDF Pro and Calibre

Adobe pdf pro to crop page numbers, join ruptured paragraphs and produce html file, Calibre to create different formats.

1. Open your pdf with Adobe PDF Pro, and choose Document > Crop pages. Using different options available, crop page numbers out. 

2. Save you document as html file. This process will join half-cut paragraphs. Careful, when you crop a pdf page, the data is still there but pdf viewer does not display it. If you drop your cropped pdf into Calibre, Calibre will recognize cropped data so even after conversion, you will see page numbers still there. 

3. Open html file with an html editor, notepad or wordpad, fix anything you want and remove unnecessary sections. Study html for better conversion via Calibre.

4. Drop html into Calibre. Fill in information and convert it. You can always create multiple level TOC in Calibre by using tags, attributes and values.

Edit: With new Adobe Acrobat Pro, things are little different. Here I am going to explain how to crop out headers and footers permanently. 

1. Open your pdf with Adobe Acrobat Pro.

2. Click Tools >> Pages >> Crop
  Set margins and crop document. You can use different page range, odd and event page settings. 

3. Once you cropped your file Click Tools >> Protection >> Remove hidden information. 

4. You will see Status: Finding hidden information, then Results . Once all the hidden information found, you can check/uncheck each group of information. 

5. Click Remove.

6. Save your document. You have removed page numbers and headers and other information that you cropped out, permanently. 

Note: Dropping cropped pdf into Calibre directly may not yield good results. Especially if you have unicode characters on your pdf. Better option, first convert it html first.

Once you have cropped pdf without hidden information, you can either use Adobe Acrobat Pro or Calibre for pdf to html conversion. So I am going to explain following steps for both Adobe Acrobat Pro and Calibre.

If you are going to use Adobe Acrobat Pro:
7. Now, lets save our pdf as html before converting it into mobi or epub document. Click File >> Save As >> More Options >> Html Web Page

If you cant save your file as html, make sure you unchecked "Run OCR if needed". For that, click "Settings" on "Save As" screen.

Keep in mind, sometimes Adobe Pdf Pro fails to apply bold or italic styling to the text and you will have plain text without bold or italic. In that case either use Mobipocket creator or Calibre's built in pdf to html conversion.

You can do some manual fix before conversion if you like. 

8. Drag and drop html file into Calibre, and set TOC and other stuff and convert.

If you are going to use Calibre:
7. Drop your pdf file into Calibre.

8. Convert you pdf into htmlz. 

Actually, Htmlz is nothing to do with html. It is a special zip file, just like epub which has all the necessary files inside to produce an ebook.

You can use Calibre's conversion settings to remove fonts, font size, margin etc. 

9. Once conversion is complete, open htmlz file with a zip software, you will see a file called index.html along with css and opf files. You can edit index file and repackage.
10. During final conversion, use htmlz as your source.

#### Using any pdf to htm converter and Textpipe Pro

Textpipe pro is a pattern based text processing tool and doesn't matter how lame the conversion is, you can bring your text to a desired look and style and format. For pdf to html, sticking to what you know is the easiest and the best way and I usually use mobipocket creator for conversion, and Textpipe for reformatting/styling and mobipocket/calibre for producing ebooks. 

If you want complete control over your ebook's style, or picky about the quality, or hate reading poorly formatted text, or always enjoy ebooks with TOC, or want to clean up messy html produced by Word processors like Ms Word (watch a screencast), or always insist on clean html format before conversion, Textpipe is the right tool for you.

Textpipe pro can do pattern based search and replace along with other jobs, and the options with it is endless but here is a brief list of things that you can do with Text pipe in terms of ebook reformating/styling.

1. You can add/remove all html tags/classes/attributes all at once with or without their text. For example: if you have a converted html text like <p style="..."> or <p class="..." style="...">, find and replace will never work for you and you have to clean up manually. But with Textpipe, it will only take seconds. Also you can remove desired class with its text completely, such as <p class="myclass"> myText </p>.
2. You can remove specific html tags/classes/attributes while keeping others. For example, you may want to remove all attributes except for italic and bold.
3. You can remove remove page numbers or titles all at once.
4. You can convert certain tags into another tags ie. h2 >> p
5. Change case after restricting the text, like changing case of text that lies in certain tag or certain class.
6. Since some ebook readers do not support small caps, you can mimic small caps as S<small>MALL</small>. First, you can restrict your text based on pattern, like being between certain tag or class. Then you can add <small> to not the first but remaining letters of the words. Sounds complicated but it is really very easy with subfilters and takes seconds.
7. Joining ruptured paragraphs/sentences
8. Remove extra spaces and tabs
9. Shifting and swapping text
10. Splitting and joining multiple htmls
11. Changing text encoding system (ansi, unicode, utf-8)
12. Adding/removing italics or bolds.

Learning curve may look a bit steep but it is not. Just take a look and play around. I am planning on doing an extended tutorial on it later.