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

| Column           | Type       | Options                 |
| ---------------- | ---------- | ----------------------- |
| email            | string     | null: false unique:true |
| password         | string     | null: false             |
| nickname         | string     | null: false             |
| first_name       | string     | null: false             |
| first_name_kana  | string     | null: false             |
| family_name      | string     | null: false             |
| family_name_kana | string     | null: false             |
| birthday         | date       | null: false             |


### Association

- has_many :items through: user_items
- has_many :user_items


## items テーブル

| Column              | Type        | Options                        |
| --------------------| ----------- | ------------------------------ |
| name                | string      | null: false                    |
| description         | string      | null: false                    |
| image_id            | integer     | null: false                    |
| price_id            | integer     | null: false                    |
| status_id           | integer     | null: false                    |
| category_id         | integer     | null: false                    |
| delivery_charge_id  | integer     | null: false                    |
| shipment_source_id  | integer     | null: false                    |
| transport_days_id   | integer     | null: false                    |
| user                | references  | null: false, foreign_key: true |

### Association


- has_many :users, through: user_items
- belong_to :user_items




## user_items テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belong_to :item
- belong_to :user
- has_one :orders_information


## orders_information テーブル

| Column                 | Type        | Options                        |
| ---------------------- | ----------- | ------------------------------ |
| shipping_address       | string      | null: false                    |
| postal_code            | string      | null: false                    |
| prefectures            | string      | null: false                    |
| municipality           | string      | null: false                    |
| phone_number           | string      | null: false                    |
| user_items             | references  | null: false, foreign_key: true |



### Association

- belongs_to :user_items



