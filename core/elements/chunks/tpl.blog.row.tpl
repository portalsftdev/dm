{if ($idx - 1) % 3 == 0}<div class="row">{/if}
    <div class="col-lg-4 col-md-12 wow fadeIn mt-5" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeIn;">
        <div class="card" itemprop="blogPost" itemscope itemtype="http://schema.org/BlogPosting">
            <div class="view overlay hm-white-slight">
                <a href="{$_modx->makeUrl($id)}">
                    <img src="{$card}" class="img-fluid" alt="{$pagetitle | escape}" itemprop="image">
                    <div class="mask"></div>
                </a>
            </div>
            <div class="card-block text-xs-center py-4 {$bg_class} {$color_class}">
                <!--Title-->
                <div class="card-title h4 thin-300 mb-0 text-capitalize" itemprop="name">{$pagetitle}</div>
                <!--/Title-->
                <meta itemprop="headline" content="{$pagetitle | escape}" />
                <meta itemprop="author" content="Администратор" />
                <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
                    <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                        <meta itemprop="url" content="{$_modx->config.site_url ~ 'assets/i/logo.png'}">
                    </div>
                    <meta itemprop="name" content="Администратор" />
                </div>
                <link itemprop="mainEntityOfPage" href="{$_modx->makeUrl($id)}" />
            </div>
            <div class="card-data px-4 pb-3">
            <span class="float-left">
                <i class="fa fa-calendar"> </i> {$createdon | date_format:"%Y-%m-%d %H:%M:%S" | toDateMY}
                <meta itemprop="datePublished" content="{$createdon | date_format: '%Y-%m-%d'}" />
                <meta itemprop="dateModified" content="{$updatedon | date_format: '%Y-%m-%d'}" />
                {*<a href="{$_modx->makeUrl($parent)}" class="btn btn-default btn-sm waves-effect waves-light">{$parent | pdoField}</a>*}
                {*<a class="">  <i class="fa fa-thumbs-o-up"> </i> 306</a>*}
            </span>
            <span class="float-right text-xs-right">
                <meta itemprop="description" content="{$introtext | escape}" />
                <a href="{$_modx->makeUrl($id)}" class="btn btn-outline-dvmk waves-effect" >{$_modx->config.label_readmore}</a>
            </span>
            </div>
        </div>
    </div>
{if ($idx % 3 == 0) || ($last == 1)}</div>{/if}
