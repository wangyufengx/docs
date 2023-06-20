# EasyExcel的使用

Java解析、生成Excel。

## 引入依赖

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>easyexcel</artifactId>
    <version>3.3.2</version>
</dependency>
```

## 注解的使用

| 注解              | 注解作用           |
| :---------------- | ------------------ |
| @HeadStyle        | 自定义表头样式     |
| @HeadRowHeight    | 设置表头行高       |
| @HeadFontStyle    | 自定义表头字体样式 |
| @ContentStyle     | 自定义内容样式     |
| @ContentFontStyle | 自定义内容字体样式 |
| @ContentRowHeight | 自定义内容行高     |
| @ColumnWidth      | 设置表列宽         |
| @ExcelProperty    | 设置列             |

### @HeadStyle

```java
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface HeadStyle {
    //设置数据格式
    short dataFormat() default -1;
	//将使用此样式的单元格设置为隐藏 默认不使用
    BooleanEnum hidden() default BooleanEnum.DEFAULT;
    //将使用此样式的单元格设置为锁定
    BooleanEnum locked() default BooleanEnum.DEFAULT;

    BooleanEnum quotePrefix() default BooleanEnum.DEFAULT;
	//设置单元格的水平对齐类型
    HorizontalAlignmentEnum horizontalAlignment() default HorizontalAlignmentEnum.DEFAULT;

    BooleanEnum wrapped() default BooleanEnum.DEFAULT;
	//设置单元格的垂直对齐类型
    VerticalAlignmentEnum verticalAlignment() default VerticalAlignmentEnum.DEFAULT;

    short rotation() default -1;

    short indent() default -1;

    BorderStyleEnum borderLeft() default BorderStyleEnum.DEFAULT;

    BorderStyleEnum borderRight() default BorderStyleEnum.DEFAULT;

    BorderStyleEnum borderTop() default BorderStyleEnum.DEFAULT;

    BorderStyleEnum borderBottom() default BorderStyleEnum.DEFAULT;

    short leftBorderColor() default -1;

    short rightBorderColor() default -1;

    short topBorderColor() default -1;

    short bottomBorderColor() default -1;

    FillPatternTypeEnum fillPatternType() default FillPatternTypeEnum.DEFAULT;

    short fillBackgroundColor() default -1;

    short fillForegroundColor() default -1;

    BooleanEnum shrinkToFit() default BooleanEnum.DEFAULT;

}
```

### @HeadRowHeight

```java
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface HeadRowHeight {
    /**
     * 设置表头行高，-1代表自适应
     */
    short value() default -1;
}
```

### @HeadFontStyle

```java
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface HeadFontStyle {

    /**
     * The name for the font (i.e. Arial)
     */
    String fontName() default "";

    /**
     * Height in the familiar unit of measure - points
     */
    short fontHeightInPoints() default -1;

    /**
     * Whether to use italics or not
     */
    BooleanEnum italic() default BooleanEnum.DEFAULT;

    /**
     * Whether to use a strikeout horizontal line through the text or not
     */
    BooleanEnum strikeout() default BooleanEnum.DEFAULT;

    /**
     * The color for the font
     *
     * @see Font#COLOR_NORMAL
     * @see Font#COLOR_RED
     * @see HSSFPalette#getColor(short)
     * @see IndexedColors
     */
    short color() default -1;

    /**
     * Set normal, super or subscript.
     *
     * @see Font#SS_NONE
     * @see Font#SS_SUPER
     * @see Font#SS_SUB
     */
    short typeOffset() default -1;

    /**
     * set type of text underlining to use
     *
     * @see Font#U_NONE
     * @see Font#U_SINGLE
     * @see Font#U_DOUBLE
     * @see Font#U_SINGLE_ACCOUNTING
     * @see Font#U_DOUBLE_ACCOUNTING
     */

    byte underline() default -1;

    /**
     * Set character-set to use.
     *
     * @see FontCharset
     * @see Font#ANSI_CHARSET
     * @see Font#DEFAULT_CHARSET
     * @see Font#SYMBOL_CHARSET
     */
    int charset() default -1;

    /**
     * Bold
     */
    BooleanEnum bold() default BooleanEnum.DEFAULT;
}

```

### @ContentStyle

```java
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ContentStyle {
    /**
     * Set the data format (must be a valid format). Built in formats are defined at {@link BuiltinFormats}.
     */
    short dataFormat() default -1;

    /**
     * Set the cell's using this style to be hidden
     */
    BooleanEnum hidden() default BooleanEnum.DEFAULT;

    /**
     * Set the cell's using this style to be locked
     */
    BooleanEnum locked() default BooleanEnum.DEFAULT;

    /**
     * Turn on or off "Quote Prefix" or "123 Prefix" for the style, which is used to tell Excel that the thing which
     * looks like a number or a formula shouldn't be treated as on. Turning this on is somewhat (but not completely, see
     * {@link IgnoredErrorType}) like prefixing the cell value with a ' in Excel
     */
    BooleanEnum quotePrefix() default BooleanEnum.DEFAULT;

    /**
     * Set the type of horizontal alignment for the cell
     */
    HorizontalAlignmentEnum horizontalAlignment() default HorizontalAlignmentEnum.DEFAULT;

    /**
     * Set whether the text should be wrapped. Setting this flag to <code>true</code> make all content visible within a
     * cell by displaying it on multiple lines
     *
     */
    BooleanEnum wrapped() default BooleanEnum.DEFAULT;

    /**
     * Set the type of vertical alignment for the cell
     */
    VerticalAlignmentEnum verticalAlignment() default VerticalAlignmentEnum.DEFAULT;

    /**
     * Set the degree of rotation for the text in the cell.
     *
     * Note: HSSF uses values from -90 to 90 degrees, whereas XSSF uses values from 0 to 180 degrees. The
     * implementations of this method will map between these two value-ranges accordingly, however the corresponding
     * getter is returning values in the range mandated by the current type of Excel file-format that this CellStyle is
     * applied to.
     */
    short rotation() default -1;

    /**
     * Set the number of spaces to indent the text in the cell
     */
    short indent() default -1;

    /**
     * Set the type of border to use for the left border of the cell
     */
    BorderStyleEnum borderLeft() default BorderStyleEnum.DEFAULT;

    /**
     * Set the type of border to use for the right border of the cell
     */
    BorderStyleEnum borderRight() default BorderStyleEnum.DEFAULT;

    /**
     * Set the type of border to use for the top border of the cell
     */
    BorderStyleEnum borderTop() default BorderStyleEnum.DEFAULT;

    /**
     * Set the type of border to use for the bottom border of the cell
     */
    BorderStyleEnum borderBottom() default BorderStyleEnum.DEFAULT;

    /**
     * Set the color to use for the left border
     *
     * @see IndexedColors
     */
    short leftBorderColor() default -1;

    /**
     * Set the color to use for the right border
     *
     * @see IndexedColors
     *
     */
    short rightBorderColor() default -1;

    /**
     * Set the color to use for the top border
     *
     * @see IndexedColors
     *
     */
    short topBorderColor() default -1;

    /**
     * Set the color to use for the bottom border
     *
     * @see IndexedColors
     *
     */
    short bottomBorderColor() default -1;

    /**
     * Setting to one fills the cell with the foreground color... No idea about other values
     *
     * @see FillPatternType#SOLID_FOREGROUND
     */
    FillPatternTypeEnum fillPatternType() default FillPatternTypeEnum.DEFAULT;

    /**
     * Set the background fill color.
     *
     * @see IndexedColors
     *
     */
    short fillBackgroundColor() default -1;

    /**
     * Set the foreground fill color <i>Note: Ensure Foreground color is set prior to background color.</i>
     *
     * @see IndexedColors
     *
     */
    short fillForegroundColor() default -1;

    /**
     * Controls if the Cell should be auto-sized to shrink to fit if the text is too long
     */
    BooleanEnum shrinkToFit() default BooleanEnum.DEFAULT;

}

```

### @ContentFontStyle

```java
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ContentFontStyle {

    /**
     * The name for the font (i.e. Arial)
     */
    String fontName() default "";

    /**
     * Height in the familiar unit of measure - points
     */
    short fontHeightInPoints() default -1;

    /**
     * Whether to use italics or not
     */
    BooleanEnum italic() default BooleanEnum.DEFAULT;

    /**
     * Whether to use a strikeout horizontal line through the text or not
     */
    BooleanEnum strikeout() default BooleanEnum.DEFAULT;

    /**
     * The color for the font
     *
     * @see Font#COLOR_NORMAL
     * @see Font#COLOR_RED
     * @see HSSFPalette#getColor(short)
     * @see IndexedColors
     */
    short color() default -1;

    /**
     * Set normal, super or subscript.
     *
     * @see Font#SS_NONE
     * @see Font#SS_SUPER
     * @see Font#SS_SUB
     */
    short typeOffset() default -1;

    /**
     * set type of text underlining to use
     *
     * @see Font#U_NONE
     * @see Font#U_SINGLE
     * @see Font#U_DOUBLE
     * @see Font#U_SINGLE_ACCOUNTING
     * @see Font#U_DOUBLE_ACCOUNTING
     */

    byte underline() default -1;

    /**
     * Set character-set to use.
     *
     * @see FontCharset
     * @see Font#ANSI_CHARSET
     * @see Font#DEFAULT_CHARSET
     * @see Font#SYMBOL_CHARSET
     */
    int charset() default -1;

    /**
     * Bold
     */
    BooleanEnum bold() default BooleanEnum.DEFAULT;
}
```

### @ContentRowHeight

```java
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ContentRowHeight {

    /**
     * Set the content height
     * <p>
     * -1 mean the auto set height
     *
     * @return Content height
     */
    short value() default -1;
}
```

### @ColumnWidth

```java
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ColumnWidth {

    /**
     * 列宽
     * <p>
     * -1 表示使用默认列宽
     *
     * @return 列宽
     */
    int value() default -1;
}
```

### @ExcelProperty

```java
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ExcelProperty {

    /**
     * The name of the sheet header.
     *
     * <p>
     * write: It automatically merges when you have more than one head
     * <p>
     * read: When you have multiple heads, take the last one
     *
     * @return The name of the sheet header
     */
    String[] value() default {""};

    /**
     * Index of column
     *
     * Read or write it on the index of column, If it's equal to -1, it's sorted by Java class.
     *
     * priority: index &gt; order &gt; default sort
     *
     * @return Index of column
     */
    int index() default -1;

    /**
     * Defines the sort order for an column.
     *
     * priority: index &gt; order &gt; default sort
     *
     * @return Order of column
     */
    int order() default Integer.MAX_VALUE;

    /**
     * Force the current field to use this converter.
     *
     * @return Converter
     */
    Class<? extends Converter<?>> converter() default AutoConverter.class;

    /**
     *
     * default @see com.alibaba.excel.util.TypeUtil if default is not meet you can set format
     *
     * @return Format string
     * @deprecated please use {@link com.alibaba.excel.annotation.format.DateTimeFormat}
     */
    @Deprecated
    String format() default "";
}
```

## Excel读

https://easyexcel.opensource.alibaba.com/docs/current/quickstart/read

## Excel写

https://easyexcel.opensource.alibaba.com/docs/current/quickstart/write

## 填充

https://easyexcel.opensource.alibaba.com/docs/current/quickstart/fill



## 参考文献

https://github.com/alibaba/easyexcel

https://easyexcel.opensource.alibaba.com/