{extends 'template:base'}
{block 'content'}
<section class="py-4">
<div class="container" id="contacts">
    <h1 class="h2">{$_modx->resource.longtitle ?: $_modx->resource.pagetitle}</h1>
    <div id="map" class="mb-3 contacts-map">&nbsp;</div>
    {ignore}
    <script>
        function initMap() {
            // Locations can be obtained by Geocoding API:
            // https://maps.googleapis.com/maps/api/geocode/json?address=QUERY_HERE&key=API_KEY_HERE
            var locations = [
    {/ignore}
                {$_modx->runSnippet('@FILE snippets/dmCities.php', ['mode' => 'locations', 'tpl' => '@FILE chunks/tpl.contacts.branchLocation.tpl'])}
    {ignore}
            ];
            // Set bounds
            var bounds = new google.maps.LatLngBounds();
            for (var i = 0; i < locations.length; i++) {
              bounds.extend(locations[i]);
            }
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 14,
                center: bounds.getCenter()
            });
            // Auto-zoom if locations count more than 1
            if (locations.length > 1) {
                map.fitBounds(bounds);
            }
            // Auto-center
            // map.panToBounds(bounds);
            // Set markers
            var marker;
            for (var i = 0; i < locations.length; i++) {
                marker = new google.maps.Marker({
                  position: {lat: locations[i].lat, lng: locations[i].lng},
                  map: map
                });
            }
        }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBTHBPz82OEgRIIKH2kv_ThzBkpdo-86Po&callback=initMap&language=ru">
    </script>
    {/ignore}


<style>

</style>

<div class="row m-0">
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Режим работы отдела продаж</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Телефон</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Эл. почта</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Адрес</div>
</div>
{$_modx->runSnippet('@FILE snippets/dmCities.php', ['mode' => 'contacts', 'tpl' => '@FILE chunks/tpl.contacts.branchInfo.tpl'])}

<div class="row m-0">
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Режим работы склада</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Телефон</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Эл. почта</div>
    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-xs-12 text-center d-none d-lg-block contacts-branch-heading">Адрес</div>
</div>
{$_modx->runSnippet('@FILE snippets/dmCities.php', ['mode' => 'storages', 'tpl' => '@FILE chunks/tpl.contacts.branchInfo.tpl'])}

</div>


</section>

{/block}
