<meta charset="{$_modx->config.modx_charset}">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
{*<meta name="viewport" content="width=device-width, initial-scale=1.0">*}
<meta name="description" content="{$_modx->resource.description}">
<meta name="author" content="">
<base href="{$_modx->config.site_url}" />
<title>{$_modx->runSnippet('!pdoTitle')} / {$_modx->config.site_name}</title>

{$_modx->RunSnippet('!MinifyX', [
    'cssSources' => 
        $_modx->config.assets_url ~ 'css/bootstrap.css' ~ ', ' ~
        $_modx->config.assets_url ~ 'css/lightgallery.css' ~ ', ' ~
        $_modx->config.assets_url ~ 'css/screen.css' ~ ', ' ~
        $_modx->config.assets_url ~ 'css/kladr.css' ~ ', ' ~
        $_modx->config.assets_url ~ 'css/dropzone.css' ~ ', ' ~
        $_modx->config.assets_url ~ 'css/screen2.css' ~  ', ' ~
    ,
    'minifyCss' => true,
    'cssFilename' => 'app',
])}

{$_modx->getPlaceholder('MinifyX.css')}

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>-->
<!--<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>-->
{*<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>*}
<!--[endif]-->

{ignore}
<!-- Google Analytics -->
<script>
(function(i,s,o,g,r,a,m){ i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-115152269-1', 'auto');
ga('send', 'pageview');
</script>
<!-- End Google Analytics -->

<!-- Yandex.Metrika counter --> <script type="text/javascript" > (function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter47956511 = new Ya.Metrika({ id:47956511, clickmap:true, trackLinks:true, accurateTrackBounce:true, webvisor:true }); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = "https://mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks"); </script> <noscript><div><img src="https://mc.yandex.ru/watch/47956511" style="position:absolute; left:-9999px;" alt="" /></div></noscript> <!-- /Yandex.Metrika counter -->
{/ignore}

