<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ws="urn:com.workday/workersync"
  exclude-result-prefixes="ws">

  <xsl:output method="text" encoding="UTF-8"/>

  <!-- CSV header -->
  <xsl:template match="/">
    <xsl:text>"Full Name","Employee Status","Employee Number","Last Name","First Name","Middle Name","Gender","Business Email","Business_Title","Hire Date","Business Unit","Department"</xsl:text>
    <xsl:text>&#10;</xsl:text>

    <xsl:for-each select="//ws:Worker[ws:Status/ws:Employee_Status = 'Active' or ws:Status/ws:Employee_Status = 'OnLeave']">
      <xsl:variable name="businessUnit" select="ws:Position/ws:Organization_Data[ws:Organization_Type='Company']/ws:Organization"/>
      <xsl:variable name="costCenterRaw" select="ws:Position/ws:Organization_Data[ws:Organization_Type='Cost_Center']/ws:Organization"/>

      <xsl:if test="starts-with($businessUnit, 'ESI') or ($businessUnit = 'EUK' and $costCenterRaw = 'ELGBR10121775')">
        <xsl:call-template name="output-row"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- Output a worker's row -->
  <xsl:template name="output-row">
    <xsl:variable name="legal" select="ws:Personal/ws:Name_Data[ws:Name_Type='Legal']"/>
    <xsl:variable name="preferred" select="ws:Personal/ws:Name_Data[ws:Name_Type='Preferred']"/>
    <xsl:variable name="workEmail" select="ws:Personal/ws:Email_Data[ws:Email_Type='WORK']/ws:Email_Address"/>
    <xsl:variable name="status" select="ws:Status/ws:Employee_Status"/>
    <xsl:variable name="hireDate" select="ws:Status/ws:Hire_Date"/>
    <xsl:variable name="terminationDate" select="ws:Status/ws:Termination_Date"/>
    <xsl:variable name="effectiveDate" select="ws:Position/ws:Effective_Date"/>
    <xsl:variable name="businessTitle" select="ws:Position/ws:Business_Title"/>
    <xsl:variable name="businessUnit" select="ws:Position/ws:Organization_Data[ws:Organization_Type='Company']/ws:Organization"/>
    <xsl:variable name="costCenterRaw" select="ws:Position/ws:Organization_Data[ws:Organization_Type='Cost_Center']/ws:Organization"/>

    <!-- Padded cost center -->
    <xsl:variable name="costCenter">
      <xsl:choose>
        <xsl:when test="string-length($costCenterRaw) &lt; 8">
          <xsl:call-template name="pad-left">
            <xsl:with-param name="input" select="$costCenterRaw"/>
            <xsl:with-param name="length" select="8"/>
            <xsl:with-param name="padChar" select="'0'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$costCenterRaw"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Transformed status -->
    <xsl:variable name="statusShort">
      <xsl:choose>
        <xsl:when test="$status = 'Active'">A</xsl:when>
        <xsl:when test="$status = 'OnLeave'">L</xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>

    <!-- Full legal name -->
    <xsl:variable name="fullLegalName">
      <xsl:value-of select="normalize-space(concat($legal/ws:First_Name, ' ', $legal/ws:Middle_Name, ' ', $legal/ws:Last_Name))"/>
    </xsl:variable>

    <!-- Combined fields string -->
    <xsl:variable name="line" select="concat(
      $fullLegalName, '|',
			$statusShort, '|',
      ws:Summary/ws:Employee_ID, '|',
			$legal/ws:Last_Name, '|',
      $legal/ws:First_Name, '|',
      $legal/ws:Middle_Name, '|',      
      ws:Personal/ws:Gender, '|',
      $workEmail, '|',
      $businessTitle, '|',			
      $hireDate, '|',
      $businessUnit, '|',
      $costCenter
    )"/>

    <xsl:call-template name="output-fields">
      <xsl:with-param name="fields" select="$line"/>
    </xsl:call-template>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <!-- Escape and quote fields -->
  <xsl:template name="output-fields">
    <xsl:param name="fields"/>
    <xsl:choose>
      <xsl:when test="contains($fields, '|')">
        <xsl:call-template name="escape">
          <xsl:with-param name="text" select="substring-before($fields, '|')"/>
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="output-fields">
          <xsl:with-param name="fields" select="substring-after($fields, '|')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="escape">
          <xsl:with-param name="text" select="$fields"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Quote and escape double quotes -->
  <xsl:template name="escape">
    <xsl:param name="text"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="translate($text, '&quot;', '&quot;&quot;')"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <!-- Pad a string from the left -->
  <xsl:template name="pad-left">
    <xsl:param name="input"/>
    <xsl:param name="length"/>
    <xsl:param name="padChar"/>
    <xsl:param name="prefix" select="''"/>
    <xsl:variable name="needed" select="$length - string-length($input)"/>
    <xsl:choose>
      <xsl:when test="string-length($prefix) &lt; $needed">
        <xsl:call-template name="pad-left">
          <xsl:with-param name="input" select="$input"/>
          <xsl:with-param name="length" select="$length"/>
          <xsl:with-param name="padChar" select="$padChar"/>
          <xsl:with-param name="prefix" select="concat($padChar, $prefix)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($prefix, $input)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
