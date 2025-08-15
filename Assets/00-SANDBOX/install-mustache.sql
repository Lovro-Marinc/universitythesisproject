use DEV_Indigomat
go
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF (SCHEMA_ID('mustache') IS NULL) BEGIN


    EXEC sp_executeSql @sql = N'CREATE SCHEMA [mustache]';



        /**
        Processes simple tags for a mustache template
        
        @module mustache/s_render_tag
        @see module:mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @param {nvarchar(128)} @tag - the name of the placeholder tag to render (substitute)
        @param {nvarchar(max)} @value - the value to subsitute for the placeholder tag 
        @returns {nvarchar(max)} the @template with any @tag's replaced with @value
        
        @date 2020-07-10
        @author James Kelly
        
        @example
        this is an example
        */
        CREATE OR ALTER FUNCTION mustache.s_render_tag
    (
    @template NVARCHAR(max),
    @tag NVARCHAR(128),
    @value NVARCHAR(max)
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc		NVARCHAR(max)	= @template;
            DECLARE @docLen		INT				= LEN(@doc);
            DECLARE @emptyCnt	INT				= 0;
        
            --replace with unescaped html
            SET @doc = REPLACE(@doc, CONCAT(N'{{{', @tag, N'}}}'), @value);
        
            --replace with unescaped html - alternate syntax
            SET @doc = REPLACE(@doc, CONCAT(N'{{& ', @tag, N'}}'), @value);
        
            --replace with unescaped html - alternate syntax - lenient
            SET @doc = REPLACE(@doc, CONCAT(N'{{&', @tag, N'}}'), @value);
        
            --replace with escaped html
            SET @doc = REPLACE(@doc, CONCAT(N'{{', @tag, N'}}'), CONVERT(NVARCHAR(max), (SELECT @value [*] FOR XML PATH(''))));

RETURN @doc;
END;

        
        /**
        Internal aspect - not typically called directly
        Handles sections based on objects
        
        @module mustache/s_render_section_object
        @see module:mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @param {nvarchar(128)} @section - the name of the placeholder section which will be treated as a sub-document
        @param {nvarchar(max)} @json - the JSON sub-object that will be used to render the sections and tags within the sub-document
        @returns {nvarchar(max)} the @template with sliced sub-documents spliced into it
        
        @date 2020-07-10
        @author James Kelly
        */
        CREATE OR ALTER FUNCTION mustache.s_render_section_object
    (
    @template NVARCHAR(max),
    @section NVARCHAR(128),
    @json NVARCHAR(max)
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc			NVARCHAR(max)	= @template;
            DECLARE @docLen			INT				= LEN(@doc);
        
            DECLARE @sectionTagLen	INT				= LEN(@section) + 5;
            DECLARE @patOpen		NVARCHAR(256)	= CONCAT(N'%{{#', @section, N'}}%');
            DECLARE @patClose		NVARCHAR(256)	= CONCAT(N'%{{/', @section, N'}}%');
            DECLARE @patOpenOff		NVARCHAR(256)	= CONCAT(N'%{{^', @section, N'}}%');
        
            WHILE (@doc LIKE @patOpen)
BEGIN
                    DECLARE @sectionIdx		INT				= PATINDEX(@patOpen, @doc);
                    DECLARE @sectionLen		INT				= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
        
                    DECLARE @blockIdx		INT				= @sectionIdx + @sectionTagLen;
                    DECLARE @blockLen		INT				= @sectionLen - (2 * @sectionTagLen);
                    DECLARE @blockDoc		NVARCHAR(max)	= SUBSTRING(@doc, @blockIdx, @blockLen);
        
                    SET @blockDoc			= mustache.s_render(@blockDoc, @json);
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, @blockDoc);
        
                    SET @sectionIdx			= PATINDEX(@patOpenOff, @doc);
        
                    IF (@sectionIdx = 0)
BEGIN CONTINUE; END
        
                    SET @sectionLen			= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
                    SET @blockDoc			= N'';
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, COALESCE(@blockDoc, N''));
END

RETURN @doc;
END;


        /**
        Internal aspect - not typically called directly
        Handles boolean values to switch sections on and off including inversions
        
        @module mustache/s_render_section_bool
        @see module:mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @param {nvarchar(128)} @section - the name of the placeholder section which will be treated as a sub-document
        @param {bit} @boolValue - the boolean value to determine if a section or its inversion (if any) are on or off
        @returns {nvarchar(max)} the @template with any falsey @sections removed (or inverted)
        
        @date 2020-07-10
        @author James Kelly
        */
        CREATE OR ALTER FUNCTION mustache.s_render_section_bool
    (
    @template NVARCHAR(max),
    @section NVARCHAR(128),
    @boolVal BIT
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc			NVARCHAR(max)	= @template;
            DECLARE @docLen			INT				= LEN(@doc);
        
            DECLARE @sectionTagLen	INT				= LEN(@section) + 5;
            DECLARE @patOpen		NVARCHAR(256)	= CONCAT(N'%{{#', @section, N'}}%');
            DECLARE @patClose		NVARCHAR(256)	= CONCAT(N'%{{/', @section, N'}}%');
            DECLARE @patOpenOff		NVARCHAR(256)	= CONCAT(N'%{{^', @section, N'}}%');
        
            DECLARE @blockIdx		INT;
            DECLARE @blockLen		INT;
            DECLARE @blockDoc		NVARCHAR(max);
        
            WHILE (@doc LIKE @patOpen)
BEGIN
                    DECLARE @sectionIdx		INT				= PATINDEX(@patOpen, @doc);
                    DECLARE @sectionLen		INT				= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
        
                    IF (@boolVal = 1)
BEGIN
                            SET @blockIdx		= @sectionIdx + @sectionTagLen;
                            SET @blockLen		= @sectionLen - (2 * @sectionTagLen);
                            SET @blockDoc		= COALESCE(SUBSTRING(@doc, @blockIdx, @blockLen), N'');
END
ELSE
BEGIN
                            SET @blockDoc		= N'';
END
        
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, @blockDoc);
        
                    SET @sectionIdx			= PATINDEX(@patOpenOff, @doc);
        
                    IF (@sectionIdx = 0)
BEGIN CONTINUE; END
        
                    SET @sectionLen			= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
        
                    IF (@boolVal = 0)
BEGIN
                            SET @blockIdx		= @sectionIdx + @sectionTagLen;
                            SET @blockLen		= @sectionLen - (2 * @sectionTagLen);
                            SET @blockDoc		= COALESCE(SUBSTRING(@doc, @blockIdx, @blockLen), N'');
END
ELSE
BEGIN
                            SET @blockDoc		= N'';
END
        
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, COALESCE(@blockDoc, N''));
END

RETURN @doc;
END;


        /**
        Internal aspect - not typically called directly
        Handles array elements by slicing sub-documents, creating a templated
        copy for each element in the array and then splicing the final
        rendered sub-documents into the main
        
        @module mustache/s_render_section_array
        @see module:mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @param {nvarchar(128)} @section - the name of the placeholder section which will be treated as a sub-document
        @param {nvarchar(max)} @json - the JSON array that will be used to render the internal tags and ext of the sections within the sub-document
        @returns {nvarchar(max)} the @template with any @tag's replaced with @value
        
        @date 2020-07-10
        @author James Kelly
        */
        CREATE OR ALTER FUNCTION mustache.s_render_section_array
    (
    @template NVARCHAR(max),
    @section NVARCHAR(128),
    @json NVARCHAR(max)
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc			NVARCHAR(max)	= @template;
            DECLARE @docLen			INT				= LEN(@doc);
        
            DECLARE @sectionTagLen	INT				= LEN(@section) + 5;
            DECLARE @patOpen		NVARCHAR(256)	= CONCAT(N'%{{#', @section, N'}}%');
            DECLARE @patClose		NVARCHAR(256)	= CONCAT(N'%{{/', @section, N'}}%');
            DECLARE @patOpenOff		NVARCHAR(256)	= CONCAT(N'%{{^', @section, N'}}%');
        
            DECLARE @tblEl			TABLE (
                                                val NVARCHAR(max),
                                                seq INT
                                            );
        
            DECLARE @elCnt			INT				= 0;

INSERT INTO @tblEl (val, seq)
SELECT x.[value] val, ROW_NUMBER() OVER(ORDER BY (SELECT 1)) seq
FROM OPENJSON(@json, N'$') x;
SET @elCnt				= @@ROWCOUNT;
        
            DECLARE @blockIdx		INT;
            DECLARE @blockLen		INT;
            DECLARE @blockDoc		NVARCHAR(max);
        
            WHILE (@doc LIKE @patOpen)
BEGIN
                    DECLARE @sectionIdx		INT				= PATINDEX(@patOpen, @doc);
                    DECLARE @sectionLen		INT				= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
        
                    IF (@elCnt = 0)
BEGIN
                            SET @blockDoc		= N'';
END
ELSE
BEGIN
                            SET @blockIdx		= @sectionIdx + @sectionTagLen;
                            SET @blockLen		= @sectionLen - (2 * @sectionTagLen);
                            SET @blockDoc		= COALESCE(SUBSTRING(@doc, @blockIdx, @blockLen), N'');

SELECT @blockDoc = STRING_AGG(
        mustache.s_render(@blockDoc, x.val)
    , N''
                   ) WITHIN GROUP (ORDER BY x.seq)
FROM @tblEl x;
END
        
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, COALESCE(@blockDoc, N''));
        
                    SET @sectionIdx			= PATINDEX(@patOpenOff, @doc);
        
                    IF (@sectionIdx = 0)
BEGIN CONTINUE; END
        
                    SET @sectionLen			= PATINDEX(@patClose, @doc) + @sectionTagLen - @sectionIdx;
        
                    IF (@elCnt = 0)
BEGIN
                            SET @blockIdx			= @sectionIdx + @sectionTagLen;
                            SET @blockLen			= @sectionLen - (2 * @sectionTagLen);
                            SET @blockDoc			= COALESCE(SUBSTRING(@doc, @blockIdx, @blockLen), N'');
END
ELSE
BEGIN
                            SET @blockDoc		= N'';
END
        
                    SET @doc				= STUFF(@doc, @sectionIdx, @sectionLen, COALESCE(@blockDoc, N''));
END

RETURN @doc;
END;


        /**
        Internal aspect - not typically called directly
        Cleans up any remaining sections and comments that were not covered
        
        @module mustache/s_render_clean
        @see module:mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @returns {nvarchar(max)} the @template with any @tag's replaced with @value
        
        @date 2020-07-10
        @author James Kelly
        */
        CREATE OR ALTER FUNCTION mustache.s_render_clean
    (
    @template NVARCHAR(max)
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc			NVARCHAR(max)	= @template;
            DECLARE @docLen			INT				= LEN(@doc);
        
            DECLARE @patOpen		NVARCHAR(256)	= N'%{{#%';
            DECLARE @patTagEnd		NVARCHAR(256)	= N'%}}%';
        
            DECLARE @idxTagStart	INT;
            DECLARE @idxTagLen		INT;
        
            DECLARE @tag			NVARCHAR(256);
        
            WHILE (@doc LIKE @patOpen)
BEGIN
                    SET @idxTagStart	= PATINDEX(@patOpen, @doc) + 3;
                    SET @tag			= SUBSTRING(@doc, @idxTagStart, @docLen);
                    SET @idxTagLen		= PATINDEX(@patTagEnd, @tag) - 1;
                    SET @tag			= SUBSTRING(@doc, @idxTagStart, @idxTagLen);
        
                    SET @doc			= mustache.s_render(@doc, CONCAT(N'{"', @tag, N'":false}'));
END
        
            SET @patOpen			= N'%{{%';
            SET @patTagEnd			= N'%}}%';
        
            WHILE (@doc LIKE @patOpen)
BEGIN
                    SET @idxTagStart	= PATINDEX(@patOpen, @doc);
                    SET @tag			= SUBSTRING(@doc, @idxTagStart, @docLen);
                    --the patIndex already is inclusive of the first } so just add 1
                    SET @idxTagLen		= PATINDEX(@patTagEnd, @tag) + 1;
                    SET @tag			= SUBSTRING(@tag, 1, @idxTagLen);
        
                    SET @doc			= REPLACE(@doc, @tag, N'');
END

RETURN @doc;
END;

        /**
        Renders a mustache template given a supporting JSON object
        
        @module mustache/s_render
        
        @param {nvarchar(max)} @template - the mustache template to render
        @param {nvarchar(max)} @json - the JSON object that will be used to render the sections and tags within the sub-document
        @returns {nvarchar(max)} the @template rendered according to the {{mustache}} specification
        
        @link
        @see https://mustache.github.io/
        
        @date 2020-07-10
        @author James Kelly
        
        @example
        DECLARE @tpl NVARCHAR(max) = N'<h1>{{header}}</h1>
        {{#bug}}
        {{/bug}}
        
        <ul>
        {{#items}}{{#first}}<li><strong>{{name}}</strong></li>{{/first}}{{#link}}<li><a href="{{url}}">{{name}}</a></li>{{/link}}
        {{/items}}</ul>
        
        {{#empty}}  <p>The list is empty.</p>{{/empty}}
        
        <p>{{notset}}{{! comment}}</p>
        ';
        
        DECLARE @obj NVARCHAR(max)	= N'{
          "header": "Colors",
          "items": [
              {"name": "red", "first": true, "url": "#Red"},
              {"name": "green", "link": true, "url": "#Green"},
              {"name": "blue", "link": true, "url": "#Blue"}
          ],
          "empty": true
        }';
        
        PRINT mustache.s_render(@tpl, @obj);
        */
        CREATE OR ALTER FUNCTION mustache.s_render
    (
    @template NVARCHAR(max),
    @json NVARCHAR(max)
    )
    RETURNS NVARCHAR(max)
    AS
BEGIN
            DECLARE @doc		NVARCHAR(max)	= @template;
        
            DECLARE @tblJson	TABLE (
                                          tag				NVARCHAR(256),
                                          val				NVARCHAR(max),
                                          valType			INT
                                      );

INSERT INTO @tblJson (tag, val, valType)
SELECT x.[key] tag, x.[value] val, x.[type] valType
FROM OPENJSON(@json, N'$') x;

SELECT @doc = mustache.s_render_section_array(@doc, s.tag, s.jsonSub)
FROM (
         SELECT x.tag, x.val jsonSub
         FROM @tblJson x
         WHERE x.valType = 4
     ) s;

SELECT @doc = mustache.s_render_section_bool(@doc, s.variable, s.boolVal)
FROM (
         SELECT x.tag variable, COALESCE(TRY_CONVERT(BIT, x.val), 0) boolVal
         FROM @tblJson x
         WHERE x.valType = 3
     ) s;

SELECT @doc = mustache.s_render_section_object(@doc, s.tag, s.jsonSub)
FROM (
         SELECT x.tag, x.val jsonSub
         FROM @tblJson x
         WHERE x.valType = 5
     ) s;

SELECT @doc = mustache.s_render_tag(@doc, s.variable, s.val)
FROM (
         SELECT x.tag variable, x.val
         FROM @tblJson x
         WHERE x.valType IN (1, 2)
     ) s;

SET @doc		= mustache.s_render_clean(@doc);

RETURN @doc;
END;
END