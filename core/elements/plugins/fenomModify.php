<?php
/** @var modx $modx */
switch ($modx->event->name) {
    case 'pdoToolsOnFenomInit':
        /** @var Fenom $fenom */

        // Usage: {$id | chCount}
        $fenom->addModifier('chCount', function ($input) use ($modx) {
            /** @var modx $modx */
            $ids = $modx->getChildIds($input);
            $count = 0;
            if (count($ids) > 0) {
                if (!empty($ids)) {
                    $count = $modx->getCount('modResource', array(
                        'id:IN' => $ids
                    , 'published' => 1
//                    , 'hidemenu' => 0
                    , 'deleted' => 0
                    , 'isfolder' => 0
                    ));
                }
            }
            return $count;
        });

        $fenom->addModifier('imgCount', function ($input) use ($modx) {
            /** @var modx $modx */
            if (empty($input)) {
                $input = $modx->resource->id;
            }
            $modx->addPackage('ms2gallery', MODX_CORE_PATH . 'components/ms2gallery/model/');
            return $modx->getCount('msResourceFile', array(
                'resource_id' => $input
                ,'active' => true
                ,'parent' => 0
            ));
        });

        $fenom->addModifier('galleryId', function ($input) use ($modx) {
            /** @var modx $modx */
            /** @var modResource $gallery */

            $gallery = $modx->getObject('modResource', array(
                'parent' => $input,
                'template' => 13,
                'deleted' => 0,
                'published' => 1
            ));
            return $gallery->id;
        });

        $fenom->addModifier('toDateMY', function ($input) {

            $date_str = date_create($input)->Format('M Y');
            $trans = array(
                "Jan" => "январь",
                "Feb" => "февраль",
                "Mar" => "март",
                "Apr" => "апрель",
                "May" => "май",
                "Jun" => "июнь",
                "Jul" => "июль",
                "Aug" => "август",
                "Sep" => "сентябрь",
                "Oct" => "октябрь",
                "Nov" => "ноябрь",
                "Dec" => "декабрь"
            );

            return strtr( $date_str, $trans);
        });

        // Usage: {$id | getImg} or {$id | getImg : 'preview'}
        $fenom->addModifier('getImg', function ($input, $path) use ($modx) {
            /** @var modx $modx */
//            $where = isset($path) ? ['path:LIKE' => '%'.$path.'%'] : ['parent' => 0];
//            $where = array_merge(['resource_id' => $input], $where);
//            $file = $modx->getObject('msResourceFile', array('resource_id' => $input, 'parent' => 0));
//            return serialize($file);
            $where = isset($path) ? ['msResourceFile.path:LIKE' => '%'.$path.'%'] : ['msResourceFile.parent' => 0];
            $where = array_merge(['msResourceFile.resource_id' => $input], $where);
            $output = $modx->runSnippet('pdoResources', [
                'class' => 'msResourceFile',
                'loadModels' => 'ms2gallery',
                'sortby' => 'rank',
                'sortdir' => 'ASC',
                'limit' => 1,
                'tplFirst' => '@INLINE {$url}',
                'tpl' => '@INLINE {$url}',
                'where' => $where
            ]);
            return $output;
        });



        break;
}
