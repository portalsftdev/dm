Здравствуйте, на сайте {$_modx->config.site_url} оставлен новый отзыв.
<br />
<br />
Автор: {$user_name}
<br />
Email: {$user_email ?: 'не указан'}
<br />
Оценка: {$rating}
<br />
Отзыв:
<br />
<br />
<div style="white-space:pre;background:#f7f7f7;padding:10px;border:1px solid #f0f0f0;">{$text}</div>
<br />
<br />
Отзыв оставлен для товара: <a target="_blank" href="{$_modx->makeUrl($resource_id, '', '', 'full')}">{$resource_pagetitle}</a>
<br />
<br />
<a target="_blank" href="{$site_manager_url}?a=resource/update&id={$resource_id}">Опубликовать отзыв (вкладка "Сообщения")</a>
