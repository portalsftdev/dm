<meta charset="{$_modx->config.modx_charset}">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
{*<meta name="viewport" content="width=device-width, initial-scale=1.0">*}
<meta name="description" content="{$_modx->resource.description | escape}">
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

{$_modx->config.site_metrics}
