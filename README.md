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

- has_many :user_items
- has_many :items


## items テーブル

| Column              | Type        | Options                        |
| --------------------| ----------- | ------------------------------ |
| name                | string      | null: false                    |
| description         | text        | null: false                    |
| price               | integer     | null: false                    |
| status_id           | integer     | null: false                    |
| category_id         | integer     | null: false                    |
| delivery_charge_id  | integer     | null: false                    |
| shipment_source_id  | integer     | null: false                    |
| transport_days_id   | integer     | null: false                    |
| user                | references  | null: false, foreign_key: true |

### Association


- has_one :user_item
- belong_to :user


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
| building_number_id     | integer     |                                |
| postal_code_id         | string      | null: false                    |
| prefectures_id         | integer     | null: false                    |
| municipality           | string      | null: false                    |
| phone_number           | string      | null: false                    |
| user_items             | references  | null: false, foreign_key: true |



### Association

- belongs_to :user_item



