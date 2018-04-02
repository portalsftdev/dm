<section>

    <div class="container-fluid container-xxl px-4">
        <h3 class="doc-title"><span>Бренды</span></h3>
    </div>

    <div class="container-fluid">

        <div class="row grid-brands">

            <div class="grid-sizer"></div>

            {$_modx->RunSnippet('@FILE snippets/dmBrands.php', ['tpl' => '@FILE chunks/sect.brands.brand.tpl'])}

        </div>

    </div>
</section>
