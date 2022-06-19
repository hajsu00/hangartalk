## Hngar Talk
Hangar Talkは、パイロットの知識や経験、フライト時間をシェアできる航空系SNSです。
操縦ライセンスの有効期限管理機能も備えています。
https://hangartalk-app.com

<img width="1673" alt="スクリーンショット 2022-06-11 21 16 25" src="https://user-images.githubusercontent.com/18317776/173187585-85a79db9-ef6f-46d2-95f2-2946902668d5.png">

### 使用技術一覧
◇バックエンド
- Ruby(3.0.1)
- Ruby on Rails(6.1.4.4)
- MySQL(8.0.28)
- Rubocop（コード解析ツール）
- RSpec（テスト）
◇フロントエンド
- Tailwind CSS
- JavaScript
◇インフラ
- AWS(ACM, RDS(MySQL 8.0.28), ECR, ECS(Fargate), S3, Route53, SES)
- GithubActions (CI, CD)
- Docker 20.10.12
- Docker-compose 1.29.2

◇インフラ構成図
<img width="909" alt="スクリーンショット 2022-06-12 10 00 02" src="https://user-images.githubusercontent.com/18317776/173209873-44a73c5a-c626-41d2-b3b9-c3460edc76f7.png">

◇ER図
<img width="1264" alt="スクリーンショット 2022-06-11 21 09 12" src="https://user-images.githubusercontent.com/18317776/173187398-e204c045-06c4-4c8b-aa31-6f760bc4ab20.png">

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
<details>
<summary>個人フライトログブック機能</summary>
パイロットのフライト記録台帳「フライトログブック」の電子版です。パイロットのこれまでの飛行時間や、離着陸回数などの情報を管理できます。

<img width="2033" alt="スクリーンショット 2022-06-19 13 39 42" src="https://user-images.githubusercontent.com/18317776/174466127-94bb5932-c7d8-414a-8eab-4d85dfccdc45.png">

</details>

<details>
<summary>グループフライト機能</summary>
複数のパイロットでグループを作ることで、メンバーのフライトをひとつのテーブルで管理できるようになります。

<img width="1975" alt="スクリーンショット 2022-06-19 13 42 42" src="https://user-images.githubusercontent.com/18317776/174466183-05382645-e22b-4bec-8051-564498376705.png">

このグループフライトの情報は、それぞれの個人フライトログブックからいつでも取得できます。

https://user-images.githubusercontent.com/18317776/174467095-9d1f39dc-f3af-4af7-83bb-d25c538f9868.mp4

</details>

<details>
<summary>フライト記録のシェア機能</summary>
個人フライトログブックに登録したフライト情報は、フィードにシェアすることができます。

<img width="875" alt="スクリーンショット 2022-06-19 14 23 09" src="https://user-images.githubusercontent.com/18317776/174467153-226363f5-5fa5-48f5-998b-51d798c1bf29.png">

</details>

### 機能一覧
◇認証機能
- 新規登録、ログイン、ログアウト、退会（論理削除）、プロフィール各種変更、アバター画像登録、カバー画像登録等の基本機能
- メール認証機能
- ゲストログイン機能
◇投稿機能
- テキスト・画像投稿、一覧、詳細等の基本機能
◇コミュニケーション機能
- いいね、シェア、コメント等の基本機能
◇フォロー機能
- 登録、解除、一覧
◇個人フライトログブック機能
- 新規作成、編集、削除の基本機能
- グループフライトからの一括インポート機能
- フィードへの投稿機能
◇グループ機能
- 新規作成、編集、削除の基本機能
- カバー画像登録機能
- 複数パイロットのフライト記録管理機能
◇操縦ライセンスの有効期限管理機能
- 新規作成、編集、削除の基本機能
- ライセンス更新試験受験履歴管理機能
- ライセンス有効期限切れお知らせ機能