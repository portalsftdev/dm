<?php

class msocFilters extends mse2FiltersHandler
{

    public function getMsocValues(array $tmp, array $ids)
    {
        $filters = $fields = $keys = array();
        foreach ($tmp as $v) {
            $v = explode('~', $v);
            $fields[array_shift($v)] = implode('~', $v);
            $keys = array_merge($keys, $v);
        }
        $keys = array_keys(array_flip($keys));
        $keys = array_merge(array('rid', 'key', 'value'), $keys);

        $classColor = 'msocColor';
        $classProductOption = 'msProductOption';
        $q = $this->modx->newQuery($classColor);
        $q->innerJoin($classProductOption, $classProductOption,
            "{$classProductOption}.key = {$classColor}.key AND {$classProductOption}.value = {$classColor}.value AND {$classProductOption}.product_id = {$classColor}.rid AND {$classColor}.active = 1");
        $q->where(array(
            "{$classColor}.rid:IN"         => $ids,
            "{$classProductOption}.key:IN" => array_keys($fields),
        ));

        $q->select($this->modx->getSelectColumns($classColor, $classColor, '', $keys, false));
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            while ($row = $q->stmt->fetch(PDO::FETCH_ASSOC)) {
                $key = strtolower($row['key']);

                //$value = str_replace(array_keys($row), array_values($row), $fields[$key]);

                $value = implode('~', array_intersect_key($row, array_flip(explode('~', $fields[$key]))));

                if (!is_array($filters[$key])) {
                    $filters[$key] = array();
                }
                if (isset($filters[$key][$value])) {
                    $filters[$key][$value][$row['rid']] = $row['rid'];
                } else {
                    $filters[$key][$value] = array($row['rid'] => $row['rid']);
                }
            }
        } else {
            $this->modx->log(modX::LOG_LEVEL_ERROR,
                "[mSearch2] Error on get filter params.\nQuery: " . $q->toSql() . "\nResponse: " . print_r($q->stmt->errorInfo(),
                    1));
        }

        return $filters;
    }

    /**
     * @link https://modx.pro/howto/13058
     *
     * @param array $keys
     * @param array $ids
     *
     * @return array
     */
    public function getMsOptionValues(array $keys, array $ids)
    {
        $filters = array();
        $q = $this->modx->newQuery('msProductOption');
        $q->where(array('key:IN' => $keys));
        $q->select('product_id, key, value');
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            if ($rows = $q->stmt->fetchAll(PDO::FETCH_ASSOC)) {
                $ids_flip = array_flip($ids);
                foreach ($rows as $row) {
                    if (!isset($ids_flip[$row['product_id']])) {
                        continue;
                    }
                    $value = str_replace('"', '"', trim($row['value']));
                    $key = strtolower($row['key']);

                    // Get ready for the special options in "key==value" format
                    if (strpos($value, '==')) {
                        list($key, $value) = explode('==', $value);
                        $key = preg_replace('/\s+/', '_', $key);
                    }
                    if (isset($filters[$key][$value])) {
                        $filters[$key][$value][$row['product_id']] = $row['product_id'];
                    } else {
                        $filters[$key][$value] = array($row['product_id'] => $row['product_id']);
                    }
                }
            }
        } else {
            $this->modx->log(modX::LOG_LEVEL_ERROR, "[mSearch2] Error on get filter params.\nQuery: " . $q->toSQL() . "\nResponse: " . print_r($q->stmt->errorInfo(), 1));
        }

        return $filters;
    }
}
