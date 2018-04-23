<div style="margin:0;border-top: 1px solid #eceeef;" itemscope itemtype="http://schema.org/Organization">
    <span class="d-none" itemprop="name">{$_modx->config.site_name}</span>
    <div class="row no-gutters" itemscope itemprop="address" itemtype="http://schema.org/PostalAddress">
        <span class="d-none" itemprop="addressLocality">г. {$city}</span>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center" style="padding:.75rem 0;">{$working_hours}</div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center" style="padding:.75rem 0;"><a class="city-phone" href="tel:{$phone_href}" itemprop="telephone">{$phone}</a></div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center" style="padding:.75rem 0;"><a href="mailto:{$email}" itemprop="email">{$email}</a></div>
        <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center" style="padding:.75rem 0;" itemprop="streetAddress">{$address}</div>
    </div>
</div>
