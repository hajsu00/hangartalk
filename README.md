## Hngar Talk
Hangar Talkは、パイロットの知識や経験、フライト時間をシェアできる航空系SNSです。
操縦ライセンスの有効期限管理機能も備えています。
https://hangartalk-app.com

（スクショ）

### 使用技術一覧
◇バックエンド
・Ruby(3.0.3)
・Ruby on Rails(6.1.4.4)
・MySQL(8.0.28)

◇フロントエンド
・Tailwind CSS
・JavaScript

◇インフラ
・AWS(ACM, RDS(MySQL 5.7), ECR, ECS(Fargate), S3, Route53, SSM)
・GithubActions (CI, CD)
・Docker 20.20.5
・Docker-compose 1.29.0
・Terraform 0.15.5

CI、CDはGithub Actionsを使用しデプロイまでに必要な作業をGitHub上で完結させています。
ローカル環境から本番環境までdockerを使用しています。
本番環境の環境変数はSSMで管理しています

◇インフラ構成図

◇ER図

◇ テスト
・RSpec

### アプリの主な機能
パイロット自身のフライトにおける離陸時刻や着陸時刻、出発地と目的地などの記録を電子的に管理をすることが主な機能です。登録されたフライト記録をフィードにシェアすることで、日本中のパイロットとコミュニケーションを取ることができます。

#### サービス選定の背景
パイロットは基本的に単一のフライトクラブやスクールに所属しています。
組織内でのコミュニケーションは密になる一方で、一歩外に出ると自分の知らない情報や考え方などにふれて戸惑うことがしばしばあります。
この、パイロット同士の考え方の違いや偏った知識と経験、そして何より、それに伴うパイロット個人の人間としての成長不足は重大事故の原因となる恐れがあります。
本アプリケーションは「人は、人とのつながりの中で成長する」という考え方と自身の航空に関する経験に基づき、パイロット同士で知識の共有と議論が行えるようなアプリケーションを目指して設計しました。

#### 類似サービスとの差別化と市場規模
本サービスは、クローズドな環境での運用が当たり前となっているパイロットのフライトログをシェアできるという点において、他サービスとは一線を画しています。
パイロット向けのフライトログ管理サービス（アプリケーション）としては国内製のものは存在しません。海外製についてはいくつか存在するようですが、いずれも個人の管理用にとどまっています。
今後も飛行経路の自動取得機能やパイロットの出発前準備の支援機能等の実装など、さらなる差別化を検討しております。
また日本国内の市場規模は非常に小さく、フライトスクールやクラブなどを合わせると５０団体ほどと見積もることができます。人数にして、１５００人程です。
一方で欧米に目を向けると、その市場規模は日本の１０倍をはるかに超えます。さらにターゲットユーザーは３０歳未満の若者がほとんどで、デジタルへの抵抗はほぼありません。
以上より、将来的に十分なスケールアップが可能であると考えております。

#### 主な機能の概要
・個人フライトログブック機能
パイロットのフライト記録台帳「フライトログブック」の電子版です。パイロットのこれまでの飛行時間や、離着陸回数などの情報を管理できます。

（スクショ）

・グループフライト機能
複数のパイロットでグループを作ることで、メンバーのフライトをひとつのテーブルで管理できるようになります。

（スクショ）

このグループフライトの情報は、それぞれの個人フライトログブックからいつでも取得できます。

（スクショ）

・フライト記録の投稿機能
個人フライトログブックに登録したフライト情報は、フィードにシェアすることができます。


### 機能一覧
◇認証機能
・新規登録、ログイン、ログアウト、退会（論理削除）、プロフィール各種変更、アバター画像登録、カバー画像登録等の基本機能
・メール認証機能
・ゲストログイン機能

◇投稿機能
・テキスト・画像投稿、一覧、詳細等の基本機能

◇コミュニケーション機能
・いいね、シェア、コメント等の基本機能

◇フォロー機能
・登録、解除、一覧

◇個人フライトログブック機能
・新規作成、編集、削除の基本機能
・グループフライトからの一括インポート機能
・フィードへの投稿機能

◇グループ機能
・新規作成、編集、削除の基本機能
・カバー画像登録機能
・複数パイロットのフライト記録管理機能

◇操縦ライセンスの有効期限管理機能
・新規作成、編集、削除の基本機能
・ライセンス更新試験受験履歴管理機能
・ライセンス有効期限切れお知らせ機能

