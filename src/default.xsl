<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output 
    method="html" 
    indent="yes" 
    doctype-public="-//W3C//DTD HTML 4.01//EN" 
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    encoding="ISO-8859-1" />

  <xsl:param name="filename"/>

  <!-- <xsl:template match="processing-instruction()">
  </xsl:template> -->

  <!-- Copy all html4 elements over to the resulting html page -->
  <xsl:template match=" a | abbr | acronym | address | applet | area | b | base | basefont | 
    bdo | big | blockquote  | body | br | button | caption | center | cite | code | col | 
    colgroup | dd | del | dfn | dir | div | dl | dt | em | fieldset     | font | form | 
    frame | frameset | h1 | h2 | h3 | h4 | h5 | h6 | head | hr | html | i | iframe | img | 
    input | ins | isindex    | kbd | label | legend | li | link | map | menu | meta | 
    noframes | noscript | object | ol | optgroup | option | p     | param | pre | q | s | 
    samp | script | select | small | span | strike | strong | style | sub | sup | table | 
    tbody | td | textarea | tfoot | th | thead | title | tr | tt | u | ul | var">

    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

  <!-- Error out on all unknown tags -->
  <xsl:template match="*">
    <xsl:message terminate="yes">
      <xsl:text>Found unknown tag: </xsl:text>
      <xsl:text>"</xsl:text><xsl:value-of select="name()"/><xsl:text>"</xsl:text>
      <xsl:value-of select="." />
    </xsl:message>
  </xsl:template>
  
  <xsl:template match="dlink">
    <a href="{@href}"><xsl:value-of select="@href" /></a>
  </xsl:template> 

  <xsl:template name="menuitem">
    <xsl:param name="name"/>    
    <xsl:param name="lowername"/>

    <xsl:choose>
      <xsl:when test="$filename = $lowername">
        <div><a class="currentmenuitem" href="{.}.html"><xsl:value-of select="."/></a></div>
      </xsl:when>
      <xsl:otherwise>
        <div><a class="menuitem" href="{.}.html"><xsl:value-of select="."/></a></div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="page">
    <html>
      <head>
        <title>Pingus - <xsl:value-of select="@title" /></title>
        <link rel="stylesheet" type="text/css" href="default.css" />
        <link rel="icon" href="images/favicon.png" type="image/png" />
        <!--<link REL="help" HREF="faq.html" title="FAQ"/>
        <link REL="section" HREF="faq.html" title="Intro"/>
        <link REL="shortcut icon" href="/favicon.ico" type="image/x-icon" />-->
      </head>
      <body style="margin:0px;">
        <table summary="" cellpadding="0" cellspacing="0" border="0" width="100%">
          <colgroup width="215" />
          <tr>
            <td valign="top" align="center">
              <a href="http://pingus.seul.org"><img src="images/logo_pingus.png" alt="Pingus" /></a>

              <div class="menu">
                <div><a class="menuitem" href="news.html">News</a></div>
                <div><a class="menuitem" href="welcome.html">Welcome</a></div>
                <div><a class="menuitem" href="download.html">Download</a></div>
                <div><a class="menuitem" href="faq.html">FAQ</a></div>
                <div><a class="menuitem" href="contact.html">Contact</a></div>
                <div><a class="menuitem" href="screenshots.html">Screenshots</a></div>
		<div><a class="menuitem" href="level_comment_tool/index.php">Level Comment Tool</a></div>
                <div><a class="menuitem" href="development.html">Development</a></div>
                <div><a class="menuitem" href="press.html">Press</a></div>
                <br /> 
                <div><a class="menuitem" href="http://savannah.nongnu.org/projects/pingus/">Savannah Project Page</a></div>

                <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
                  <input type="hidden" name="cmd" value="_xclick" />
                  <input type="hidden" name="business" value="grumbel@gmx.de" />
                  <input type="hidden" name="item_name" value="Pingus donation" />
                  <input type="hidden" name="no_note" value="1" />
                  <input type="hidden" name="currency_code" value="EUR" />
                  <input type="hidden" name="tax" value="0" />
                  <input type="image" src="https://www.paypal.com/images/x-click-but04.gif" border="0" name="submit" alt="donate via PayPal" />
                </form>
              </div>

              <p>
                <a href="http://validator.w3.org/check/referer">html4</a>/
                <a href="http://jigsaw.w3.org/css-validator/">css2</a>

                <!-- <img
                src="http://www.w3.org/Icons/valid-html401"
                alt="Valid HTML 4.01!" height="31" width="88" /> -->
                <!-- <img style="border:0;width:88px;height:31px"
                src="http://jigsaw.w3.org/css-validator/images/vcss" 
                alt="Valid CSS!" /> -->

              </p>
            </td>
            <td valign="top" style="padding:20px;">
              <!--
              <table  summary="" border="0" width="100%" cellpadding="0" cellspacing="0">
              <tr>
              <td align="left" valign="bottom">
              <h1><xsl:value-of select="@title"/></h1>
            </td><td align="right">
              <img alt="" src="images/walking.png"/>
            </td>
            </tr>
            </table>
              <br />
              -->
              
              <h1><xsl:value-of select="@title"/></h1>

              <div class="mainbody">
                <xsl:apply-templates />
              </div>
              
              <div style="font-size: smaller; text-align: right; background-color: gray; padding: 5px; border-style: solid; border-color: black; border-width: thin; margin-top: 8px;">
                Copyright &#169; 1998-2003 <a href="http://pingus.seul.org/~grumbel/">Ingo Ruhnke</a>, &lt;<a href="mailto:grumbel@gmx.de">grumbel@gmx.de</a>&gt;
              </div>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="section">
    <h2><xsl:value-of select="@title" /></h2>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="subsection">
    <h3><xsl:value-of select="@title" /></h3>
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="screenshots">
    <table summary="" width="100%" border="0" cellpadding="0"  cellspacing="0">
      
      <tr>
        <td align="center">
          <xsl:apply-templates select="item[1]"/>
        </td>
        <td align="center">
          <xsl:apply-templates select="item[2]"/>
        </td>
        <td align="center">
          <xsl:apply-templates select="item[3]"/>
        </td>
      </tr>

      <xsl:if test="count(item)>3">
        <tr>
          <td align="center">
            <xsl:apply-templates select="item[4]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[5]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[6]"/>
          </td>
        </tr>
      </xsl:if>


      <xsl:if test="count(item)>6">
        <tr>
          <td align="center">
            <xsl:apply-templates select="item[7]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[8]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[9]"/>
          </td>
        </tr>
      </xsl:if>

    </table>
  </xsl:template>

  <xsl:template match="screenshots/item">
    <a href="images/{@file}.jpg"><img class="screenshot" alt="{@file}" src="images/{@file}_small.jpg" title="{.}"/></a>
  </xsl:template>

  <xsl:template match="screenshot-menu">
    <p style="text-align: center;">
      [ 
      <a href="screenshots.html">0.6</a>
      |
      <a href="screenshots-0.5.html">0.5</a>
      |
      <a href="screenshots-0.4.html">0.4</a>
      |
      <a href="screenshots-0.3.html">0.3</a>
      |
      <a href="screenshots-0.2.html">0.2</a>
      |
      <a href="screenshots-0.1.html">0.1</a>
      |
      <a href="screenshots-0.0.html">0.0</a>
      ]
    </p>
  </xsl:template>

  <xsl:template match="netstat-image">
    <div style="text-align: right;">
      <!-- Begin Nedstat Basic code -->
      <!-- Title: Pingus -->
      <!-- URL: http://dark.x.dtu.dk/~grumbel/pingus/index.html -->
      <script type="text/javascript" language="JavaScript" src="http://m1.nedstatbasic.net/basic.js">
      </script>

      <script type="text/javascript" language="JavaScript">
        <xsl:comment>
          nedstatbasic("AAG6CQE7r43v+PiFyrKmmmG/C9Lg", 0);
          // </xsl:comment>
      </script>
      <noscript>
        <a target="_blank" href="http://v1.nedstatbasic.net/stats?AAG6CQE7r43v+PiFyrKmmmG/C9Lg"><img
            src="http://m1.nedstatbasic.net/n?id=AAG6CQE7r43v+PiFyrKmmmG/C9Lg"   
            border="0" width="18" height="18" alt="" /></a>
      </noscript>
      <!-- End Nedstat Basic code -->
    </div>
  </xsl:template>

  <xsl:template match="section-toc">
    <ul>
      <xsl:for-each select="section">
        <li><a href="#section{generate-id(.)}">
            <xsl:apply-templates/></a></li>
      </xsl:for-each>
    </ul>
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="faq-list">
    <ul>
      <xsl:for-each select="faq/question">
        <li><a href="#faq{generate-id(.)}">
            <xsl:apply-templates/></a></li>
      </xsl:for-each>
    </ul>
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="faq">
    <p></p>
    <table width="100%"  class="question">
      <colgroup width="60%" />
      <tr><td valign="top">
          <div id="faq{generate-id(question)}">
            <xsl:apply-templates select="question/node()"/>
          </div>
        </td>
        
        
        <td align="right" valign="top">
          <small>Last update:<xsl:value-of select="@date"/></small>
          [<small><a href="#faqtoc">Up</a></small>]
        </td>
      </tr>
    </table>

    <p class="answer"><xsl:apply-templates select="answer/node()"/> </p>
  </xsl:template>

  <xsl:template match="news">
    <table border="0" width="100%" cellpadding="5" cellspacing="5">
      <colgroup width="*"/>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="news/item">
    <tr>
      <td style="border-style: solid; border-width: thin; white-space: nowrap;" align="right" valign="top">
        <tt><xsl:value-of select="@date"/></tt>
      </td>
      
      <td style="background-color: rgb(180,180,180); color: black;"><xsl:apply-templates/></td>
    </tr>
  </xsl:template>

  <xsl:template match="german-flag">
    (german)
  </xsl:template>

  <xsl:template match="english-flag">
    (english)
  </xsl:template>

  <xsl:template match="dutch-flag">
    (dutch)
  </xsl:template>

</xsl:stylesheet>
