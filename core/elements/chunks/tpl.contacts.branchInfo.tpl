<div class="contacts-branch-row" itemscope itemtype="http://schema.org/Organization">
    <meta itemprop="name" content="{$_modx->config.site_name | escape}" />
    <div class="row no-gutters" itemscope itemprop="address" itemtype="http://schema.org/PostalAddress">
        <meta itemprop="addressLocality" content="г. {$city}" />
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center">{$working_hours}</div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center"><a class="city-phone" href="tel:{$phone_href}">{$phone}</a><meta itemprop="telephone" content="{$phone}" /></div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center"><a href="mailto:{$email}">{$email}</a><meta itemprop="email" content="{$email}" /></div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center" itemprop="streetAddress">{$address}</div>
    </div>
</div>
