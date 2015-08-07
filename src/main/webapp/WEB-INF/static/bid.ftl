<#include "header.ftl">
<body>
<div data-role="page">
    <div data-role="header">
        <h1>My Title</h1>
        <a>My Title</a>
        <a>My Title2</a>
    </div><!-- /header -->

    <div data-role="content">
        <ul data-role="listview" data-inset="true" data-filter="true">
            <li><a href="#">洗衣液</a></li>
            <li><a href="#">洗发水</a></li>
            <li><a href="#">洗脚</a></li>
            <li><a href="#">瞎洗</a></li>
            <li><a href="#">洗屁股</a></li>
        </ul>
        <form>
            <label for="slider-0">Input slider:</label>
            <input type="range" name="slider" id="slider-0" value="25" min="0" max="100" />



            <a href="#" data-role="button" data-icon="star " data-theme="a">Star button</a>


            <a href="#" class="ui-btn ui-shadow">Anchor</a>

            <a href="bid.html" data-role="button">Open dialog</a>


            <a href="#pagetwo" data-role="button" data-rel="dialog" data-transition="fade" data-inline="true">11111111111111111111111111</a>

            <a href="#pagetwo" data-transition="slide">滑动到页面二</a>

            <a href="index.html"  data-transition="slide" >转到外部页面</a>
        </form>
    </div><!-- /content -->

    <div data-role="footer">
        <h4>Page Footer</h4>
        <!-- /footer -->
    </div><!-- /page -->

</div>

</body>
</html>