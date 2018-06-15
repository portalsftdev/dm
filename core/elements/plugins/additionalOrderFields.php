<?php

/**
 *
 * @link https://vr66.ru/it-blog/modx-revo/turnkey-solutions-for-modx/92-add-your-fields-in-the-order-form
 * @link https://modx.pro/help/8438/
 *
 */

switch ($modx->event->name) {
    case 'msOnBeforeCreateOrder':
        // Set additional order fields
        $address = $msOrder->getOne('Address');
        // Set selected city
        $address->set('city', $_SESSION['cityselector.current_city']);
        // Fields can be system setting
        $additionalOrderFields = [
            'payer_type',
            'company',
            'legal_address',
            'inn',
            'kpp',
            // 'requisites',
            'measuring',
            'installation',
        ];
        $legalEntity = !empty($_POST['payer-type']) && $_POST['payer-type'] == 'Юридическое лицо';
        $legalEntityFields = [
            'company',
            'legal_address',
            'inn',
            'kpp',
            // 'requisites',
        ];
        $properties = [];
        foreach ($_POST as $key => $value){
            // Replace hyphens to underscores
            $key = str_replace('-', '_', $key);
            if (in_array($key, $additionalOrderFields)) {
                if (!$legalEntity && in_array($key, $legalEntityFields)) {
                    continue;
                }
                $properties[$key] = htmlentities($value ?: 'Не указано', ENT_COMPAT | ENT_HTML401, 'UTF-8');
            }
        }
        if (count($properties) > 0) {
            $address->set('properties', json_encode($properties));
        }
    break;

    case 'msOnCreateOrder':
        define('ORDER_FILE_FOLDER_REL_PATH', $modx->getOption('order_files_folder'));
        define('ORDER_FILE_FOLDER_ABS_PATH', $_SERVER['DOCUMENT_ROOT'] . ORDER_FILE_FOLDER_REL_PATH);
        define('ORDER_FILE_TMP_FOLDER_ABS_PATH', ORDER_FILE_FOLDER_ABS_PATH . '/tmp');
        $orderID = $msOrder->get('id');
        $orderFolder = ORDER_FILE_FOLDER_ABS_PATH . '/' . $orderID;
        // Create order folder if it doesn't exist
        if (!is_dir($orderFolder)) {
            mkdir($orderFolder);
        }
        $orderTmpFolder = ORDER_FILE_TMP_FOLDER_ABS_PATH . '/' . session_id();
        $orderFiles = array_diff(scandir($orderTmpFolder), ['.', '..']);
        $requisitesFiles = [];
        // Move order files from temporary folder to the order folder and set it to requisites
        foreach ($orderFiles as $orderFile) {
            rename($orderTmpFolder . '/' . $orderFile, $orderFolder . '/' . $orderFile);
            $requisitesFiles[] = ORDER_FILE_FOLDER_REL_PATH . '/' . $orderID . '/' . $orderFile;
        }
        // Merge address properties with requisites
        $address = $msOrder->getOne('Address');
        $addressProperties = $address->get('properties');
        $addressProperties = array_merge($addressProperties, ['requisites' => sizeof($requisitesFiles) > 0 ? $requisitesFiles : 'Не указано']);
        $address->set('properties', json_encode($addressProperties));
        $address->save();
        // Temporary folder will be removed during next file upload
        break;

    case 'msOnManagerCustomCssJs':
        if ($page != 'orders') return;
	$modx->controller->addHtml("
            <script type='text/javascript'>
                Ext.ComponentMgr.onAvailable('minishop2-window-order-update', function(){
                	if (miniShop2.config['order_address_fields'].in_array('properties')){
                		if (this.record.addr_properties){
                		    var key;
                			for (key in this.record.addr_properties) {
                			    if (key == 'requisites' && this.record.addr_properties[key] instanceof Array) {
            			            for (i = 0; i < this.record.addr_properties[key].length; i++) {
                        				this.fields.items[2].items.push(
                        					{
                        						xtype: 'displayfield',
                        						name: 'addr_properties_'+key,
                        						fieldLabel: _('ms2_properties_'+key),
                        						anchor: '100%',
                        						style: 'border:1px solid #efefef;width:95%;padding:5px;',
                        						html: '<a download href=\"' + location.protocol + '//' + location.hostname + this.record.addr_properties[key][i] + '\">' +
                    			                    location.protocol + '//' + location.hostname + this.record.addr_properties[key][i] +
                    			                '</a>'
                        					}
                        				);
            			            }
                			    } else {
                    				this.fields.items[2].items.push(
                    					{
                    						xtype: 'displayfield',
                    						name: 'addr_properties_'+key,
                    						fieldLabel: _('ms2_properties_'+key),
                    						anchor: '100%',
                    						style: 'border:1px solid #efefef;width:95%;padding:5px;',
                    						html: this.record.addr_properties[key]
                    					}
                    				);
                			    }
                			}
                		}
                	}
                });
            </script>");
    break;
}
