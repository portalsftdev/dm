miniShop2.plugin.pluginname = {
    getFields: function(config) {
        return {
            gift_standart_installation: {
                xtype: 'xcheckbox',
                inputValue: 1,
                checked: parseInt(config.record.popular),
                description: '<b>[[+gift_standart_installation]]</b><br />' + 'Стандартный монтаж в подарок',
                boxLabel: 'Стандартный монтаж в подарок'
            }
        }
    },
    getColumns: function() {
        return {
            gift_standart_installation: {
                width: 50,
                sortable: true,
                header: 'Стандартный монтаж в подарок',
                editor: {
                    xtype: 'combo-boolean',
                    renderer: 'boolean',
                }
            }
        }
    }
};
