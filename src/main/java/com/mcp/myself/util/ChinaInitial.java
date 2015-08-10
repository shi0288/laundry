package com.mcp.myself.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/9.
 */
public class ChinaInitial {

    public static void main(String[] args) {
        String str = "444";
        if(getPYIndexStr(str.split("")[1],true)==null){
            System.out.println(111);
        }
        String rst=getPYIndexStr(str.split("")[1],true);
        try {
            int _rst=Integer.parseInt(rst);
            System.out.println(_rst);
        }catch (NumberFormatException e){
            System.out.println(rst);
        }


}


    private static Map<String, String> exceptWords = new HashMap<String, String>();

    static {
        exceptWords.put("A", "庵鳌");
        exceptWords.put("B", "璧亳並侼別匂");
        exceptWords.put("C", "茌丞丒丳刅");
        exceptWords.put("D", "渎砀棣儋丟");
        exceptWords.put("F", "邡冹兝");
        exceptWords.put("G", "崮藁莞丐丱乢亁仠冮匃匄");
        exceptWords.put("H", "骅珲潢湟丆冴匢");
        exceptWords.put("J", "泾蛟暨缙旌莒鄄丌丩丮丯丼亅伋冏匊匛匞");
        exceptWords.put("K", "丂匟");
        exceptWords.put("L", "崂涞栾溧漯浏耒醴泸阆崃両刢劽啰");
        exceptWords.put("M", "渑汨丏冐冺兞冇");
        exceptWords.put("O", "瓯");
        exceptWords.put("P", "邳濮郫丕冸");
        exceptWords.put("Q", "喬綦衢岐朐邛丠丬亝冾兛匤");
        exceptWords.put("R", "榕刄");
        exceptWords.put("S", "泗睢沭嵊歙莘嵩鄯丄丗侺兙嗄");
        exceptWords.put("T", "潼滕郯亣侹侻");
        exceptWords.put("W", "婺涠汶亾仼卍卐");
        exceptWords.put("X", "鑫盱浔荥淅浠亵丅伈兇");
        exceptWords.put("Y", "懿眙黟颍兖郓偃鄢晏丣亜伇偐円匜");
        exceptWords.put("Z", "梓涿诏柘秭圳伀冑刣");
    }


    public static String getPYIndexStr(String strChinese, boolean bUpCase) {
        try {
            StringBuffer buffer = new StringBuffer();
            byte b[] = strChinese.getBytes("GBK");
            for (int i = 0; i < b.length; i++) {
                if ((b[i] & 255) > 128) {
                    int char1 = b[i++] & 255;
                    char1 <<= 8;
                    int chart = char1 + (b[i] & 255);
                    buffer.append(getPYIndexChar((char) chart, bUpCase, strChinese));
                    continue;
                }
                char c = (char) b[i];
                if (!Character.isJavaIdentifierPart(c)) {
                    c = 'A';
                }
                buffer.append(Character.toUpperCase(c));
            }
            return buffer.toString();
        } catch (Exception e) {
            return null;
        }
    }


    private static String getPYIndexChar(char strChinese, boolean bUpCase, String propterty) {

        int charGBK = strChinese;
        String result="";
        if (charGBK >= 45217 && charGBK <= 45252)
            result = "A";
        else if (charGBK >= 45253 && charGBK <= 45760)
            result = "B";
        else if (charGBK >= 45761 && charGBK <= 46317)
            result = "C";
        else if (charGBK >= 46318 && charGBK <= 46825)
            result = "D";
        else if (charGBK >= 46826 && charGBK <= 47009)
            result = "E";
        else if (charGBK >= 47010 && charGBK <= 47296)
            result = "F";
        else if (charGBK >= 47297 && charGBK <= 47613)
            result = "G";
        else if (charGBK >= 47614 && charGBK <= 48118)
            result = "H";
        else if (charGBK >= 48119 && charGBK <= 49061)
            result = "J";
        else if (charGBK >= 49062 && charGBK <= 49323)
            result = "K";
        else if (charGBK >= 49324 && charGBK <= 49895)
            result = "L";
        else if (charGBK >= 49896 && charGBK <= 50370)
            result = "M";
        else if (charGBK >= 50371 && charGBK <= 50613)
            result = "N";
        else if (charGBK >= 50614 && charGBK <= 50621)
            result = "O";
        else if (charGBK >= 50622 && charGBK <= 50905)
            result = "P";
        else if (charGBK >= 50906 && charGBK <= 51386)
            result = "Q";
        else if (charGBK >= 51387 && charGBK <= 51445)
            result = "R";
        else if (charGBK >= 51446 && charGBK <= 52217)
            result = "S";
        else if (charGBK >= 52218 && charGBK <= 52697)
            result = "T";
        else if (charGBK >= 52698 && charGBK <= 52979)
            result = "W";
        else if (charGBK >= 52980 && charGBK <= 53688)
            result = "X";
        else if (charGBK >= 53689 && charGBK <= 54480)
            result = "Y";
        else if (charGBK >= 54481 && charGBK <= 55289)
            result = "Z";
        else {
            for (String key : exceptWords.keySet()) {
                String[] temp = exceptWords.get(key).split("");
                for (int i = 0; i < temp.length; i++) {
                    if (propterty.equals(temp[i])) {
                        result = key;
                        break;
                    }
                }
            }
        }
        if (!bUpCase){
            result = result.toLowerCase();
        }
        return result;
    }

}
