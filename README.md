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

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| name             | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| nickname         | string | null: false |
| first_name       | string | null: false |
| first_name_kana  | string | null: false |
| family_name      | string | null: false |
| family_name_kana | string | null: false |
| birthday         | string | null: false |

## items テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| product_name        | string | null: false |
| description_of_item | string | null: false |
| product_status      | string | null: false |
| category            | string | null: false |
| price               | string | null: false |
| seller              | string | null: false |
| image               | string | null: false |
| delivery_burden     | string | null: false |
| ship_from_address   | string | null: false |
| transport_days      | string | null: false |
| price_information   | string | null: false |

<!-- 購入者が成立して初めて決定する情報は、商品自体が保持すべきではない -->


## order テーブル

| Column                  | Type   | Options     |
| ----------------------- | ------ | ----------- |
| buyer                   | string | null: false |
| shipping_address        | string | null: false |
| postal_code             | string | null: false |
| prefectures             | string | null: false |
| municipality            | string | null: false |
| address                 | string | null: false |
| phone_number            | string | null: false |



## credit_card テーブル

| Column                  | Type   | Options     |
| ----------------------- | ------ | ----------- |
| credit_card_information | string | null: false |
| user_id                 | string | null: false |
| customer_id             | string | null: false |