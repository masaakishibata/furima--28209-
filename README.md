# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# テーブル設計

## users テーブル

| Column           | Type   | Options                 |
| ---------------- | ------ | ----------------------- |
| email            | string | null: false unique:true |
| password         | string | null: false             |
| nickname         | string | null: false             |
| first_name       | string | null: false             |
| first_name_kana  | string | null: false             |
| family_name      | string | null: false             |
| family_name_kana | string | null: false             |
| birthday         | date   | null: false             |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column              | Type        | Options                        |
| --------------------| ----------- | ------------------------------ |
| name                | string      | null: false                    |
| description         | string      | null: false                    |
| seller              | string      | null: false                    |
| image               | string      | null: false                    |
| price               | string      | null: false                    |
| item_status         | integer     | null: false                    |
| category            | integer     | null: false                    |
| delivery_charge     | integer     | null: false                    |
| shipment_source     | integer     | null: false                    |
| transport_days      | integer     | null: false                    |
| user_id             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :orders, through: order_items



<!-- ordersが成立して初めて決定する情報は、items自体が保持すべきではない -->

## order_items テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| order   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :order


## orders テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| user_id                 | references | null: false, foreign_key: true |
| item_id                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items, through: order_items
- has_one :orders_information



## orders_information テーブル

| Column                  | Type   | Options     |
| ----------------------- | ------ | ----------- |
| shipping_address        | string | null: false |
| postal_code             | string | null: false |
| prefectures             | string | null: false |
| municipality            | string | null: false |
| phone_number            | string | null: false |


### Association

- belongs_to :order



