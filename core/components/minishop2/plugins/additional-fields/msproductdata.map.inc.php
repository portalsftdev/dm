<?php

return array(
    'fields' => array(
        'gift_standart_installation' => 0,
    ),
    'fieldMeta' => array(
        'gift_standart_installation' => array(
            'dbtype' => 'tinyint',
            'precision' => '1',
            'attributes' => 'unsigned',
            'phptype' => 'boolean',
            'null' => true,
            'default' => 0,
        )
    ),
    'indexes' => array(
        'gift_standart_installation' => array(
            'alias' => 'gift_standart_installation',
            'primary' => false,
            'unique' => false,
            'type' => 'BTREE',
            'columns' => array(
                'gift_standart_installation' => array(
                    'length' => '',
                    'collation' => 'A',
                    'null' => false,
                ),
            ),
        ),
    ),
);
