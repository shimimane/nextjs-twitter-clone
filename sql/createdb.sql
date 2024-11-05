create DATABASE IF NOT EXISTS `nextjs_twclone` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL, -- bcryptなどでハッシュ化されたパスワードを保存
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `imageurl` varchar(255) DEFAULT NULL,
  `role` int(11) NOT NULL DEFAULT 0,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `password_reset_expiration` datetime DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tweets` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) unsigned NOT NULL,
    `content` varchar(280) NOT NULL, -- ツイートの最大文字数を280に制限
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `followers` (
    `user_id` bigint(20) unsigned NOT NULL,
    `follower_id` bigint(20) unsigned NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`, `follower_id`), -- 複合主キーで重複を防ぐ
    KEY `user_id` (`user_id`),
    KEY `follower_id` (`follower_id`),
    CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
    CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- データベースの作成:
-- データベース nextjs_twitterclone_db が存在しない場合に作成され、文字セットは utf8mb4、照合順序は utf8mb4_unicode_ci です。これは、絵文字を含む幅広い文字をサポートするために適しています。
-- 
users テーブル:
-- ユーザー情報を保存するためのテーブルです。
-- id は主キーで、自動インクリメントされます。
-- password フィールドは、セキュリティのためにハッシュ化されたパスワードを保存することをお勧めします（例えば、bcryptを使用）。
-- created_at と updated_at フィールドは、デフォルトで CURRENT_TIMESTAMP を使用して自動的に設定されるようにすると便利です。
-- email フィールドにはユニーク制約があり、重複したメールアドレスの登録を防ぎます。

-- tweets テーブル:
-- ツイートを保存するためのテーブルです。
-- user_id は users テーブルの id を参照する外部キーで、ユーザーとツイートを関連付けます。
-- ON DELETE CASCADE により、ユーザーが削除された場合、そのユーザーのツイートも自動的に削除されます。
-- created_at と updated_at フィールドも自動更新の設定を考慮すると良いでしょう。

-- followers テーブル:
-- フォロー関係を保存するためのテーブルです。
-- user_id と follower_id はどちらも users テーブルの id を参照する外部キーです。
-- ON DELETE CASCADE により、ユーザーが削除された場合、そのユーザーに関連するフォロー関係も自動的に削除されます。
-- id を主キーとしていますが、user_id と follower_id の複合主キーを使用することで、重複するフォロー関係を防ぐことができます。
-- これらの改善点を考慮することで、データベースの設計がより堅牢でセキュアになります。
