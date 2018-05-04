<article class="p-3 product-review">
    <header class="row mb-3">
        <div class="col-8 ">
            <div class="mr-3 product-reviewer-name">{$user_name}</div>
            <time>{$date|date_format:"%d/%m/%y %H:%M"}</time>
        </div>
        <div class="col-4 text-right product-review-rating">
            {foreach 1..5 as $value}
                <i class="icon-star{if $value > $rating} icon-star-o{/if} text-primary"></i>
            {/foreach}
        </div>
    </header>
    <main class="row">
        <div class="col">
            {$text}
        </div>
    </main>
</article>
