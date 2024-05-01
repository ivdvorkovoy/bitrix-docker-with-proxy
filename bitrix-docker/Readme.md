## Старт контейнера

Контейнер сделан чтобы можно было его использовать без изменений. 
Для этого необходимо скопировать файл .env_template в .env
```bash
cp .env_template .env
```
Задать переменные окружения и запустить контейнер скриптом run-container.sh
```bash
./run-container.sh
```

### Примеры конфигурации битрикса

<details><summary>bitrix/php_interface/dbconn.php</summary>

```php
define('BX_CRONTAB_SUPPORT', true);

define("BX_USE_MYSQLI", true);
define("DBPersistent", true);
define("DELAY_DB_CONNECT", true);
$DBType = "mysql";
$DBHost = "mysql";
$DBName = "<MYSQL_DATABASE>";
$DBLogin = "root";
$DBPassword = "<MYSQL_ROOT_PASSWORD>";
define('BX_TEMPORARY_FILES_DIRECTORY', '/tmp');

define("BX_CACHE_TYPE", "memcache");
define("BX_CACHE_SID", "prod"); // or "dev" in case of dev config
define("BX_MEMCACHE_HOST", "memcached");
define("BX_MEMCACHE_PORT", "11211");
define('BX_SECURITY_SESSION_MEMCACHE_HOST', 'memcached-sessions');
define('BX_SECURITY_SESSION_MEMCACHE_PORT', 11211);
```

</details>

<details><summary>bitrix/.settings.php</summary>

```php
  'session' => array (
  'value' =>
  array (
    'mode' => 'default',
    'handlers' =>
    array (
      'general' =>
      array (
        'type' => 'memcache',
        'host' => 'memcached-sessions',
        'port' => '11211',
      ),
    ),
  ),
  'readonly' => true,
  ),
  'connections' =>
  array (
    'value' =>
    array (
      'default' =>
      array (
        'className' => '\\Bitrix\\Main\\DB\\MysqliConnection',
        'host' => 'mysql',
        'database' => '<MYSQL_DATABASE>',
        'login' => 'root',
        'password' => '<MYSQL_ROOT_PASSWORD>',
        'options' => 2.0,
      ),
    ),
    'readonly' => true,
  ),
```

</details>

<details><summary>bitrix/.settings_extra.php</summary>

```php
<?php
return array(
  'cache' => array(
    'value' => array(
      'type' => 'memcache',
      'memcache' => array(
        'host' => 'memcached',
        'port' => '11211',
      ),
      'sid' => "prod" // or "dev" in case of dev config
    ),
  ),
);
?>
```

</details>

## Файловая структура

### /config

- `cron/php-cron.cron` список задач для запуска в контейнере 

- `cron/host.cron` список задач для запуска в родительской системе

- `db/<SQL_VERSION>/my.cnf` конфигурация mysql

- `nginx` конфигурация nginx 

- `php` файлы сборок и конфигурации php различных версий

### /logs

`mysql`, `nginx`, `php` Логи. Логи cron и msmtp записываются в папку `php`.

### /scripts

Скрипты для доп задач. НАпример установка прав доступа к файлам и создание бекапа БД 

### /web

Исходные файлы проекта. По умолчанию используется папка `web/www`

### /private

- `private/mysql-data` Данные БД. Такой формат был выбран для сохранности БД при пересборке контейнера

## Решенные задачи

<details>
<summary>Очистка (mem)cache</summary>

Используются два экземпляра memcached, один для кеша сайта, а другой для сеансов. Вот команды для их полной очистки:

```shell
# очистка кеша сайта
echo "flush_all" | docker exec -i memcached /usr/bin/nc 127.0.0.1 11211
# очистка кеша сессий
echo "flush_all" | docker exec -i memcached-sessions /usr/bin/nc 127.0.0.1 11211
```

[Дополнительные команды](https://github.com/memcached/memcached/wiki/Commands).

</details>
