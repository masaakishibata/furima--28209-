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

- has_one :user_items
- has_many :items
- has_many :sns_credentials
- has_many :comments


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
- has_many_attached :images
- has_many :item_tag_relations, dependent: :destroy
- has_many :tags, through: :item_tag_relations
- has_many :comments


## user_items テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :orders_information


## orders_information テーブル

| Column                 | Type        | Options                        |
| ---------------------- | ----------- | ------------------------------ |
| building_number        | string      |                                |
| postal_code            | string      | null: false                    |
| prefectures_id         | integer     | null: false                    |
| municipality           | string      | null: false                    |
| phone_number           | string      | null: false                    |
| user_item              | references  | null: false, foreign_key: true |



### Association

- belongs_to :user_items

## tags テーブル

| Column  | Type    | Options     |
| ------- | ------- | ----------- |
| tagname | string  | null: false |

### Association

- has_many :item_tag_relations
- has_many :items, through: :item_tag_relations

## item_tag_relations テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| tag     | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :tag

## sns_credentials テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| provider| string     | null: false                    |
| uid     | string     | null: false                    |
| user    | references | null                           |

### Association

- belongs_to :user, optional: true

## comments テーブル

| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| text    | text    | null: false                    |
| user_id | integer | null: false                    |
| item_id | integer | null: false                    |

### Association

- belongs_to :user
- belongs_to :item