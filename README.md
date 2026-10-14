# 梦花仓管 V1 · SQLite 云端演示版

uni-app / Vue 3 / TypeScript 前端，Fastify 后端，SQLite 本地持久化数据库。
默认运行不需要 MySQL 服务、数据库账号或外部 API 密钥。

## GitHub 全栈演示

本仓库可在 GitHub Codespaces 中运行完整的 H5、Fastify API 和 SQLite。

1. 打开仓库的 **Code → Codespaces → Create codespace on main**。
2. 首次创建会安装依赖、构建前后端并初始化演示数据库。
3. 启动后在 **Ports** 面板打开 **3101** 端口。
4. 使用 `admin` / `123456` 登录。

默认端口保持私有访问，需登录 GitHub。SQLite 保存在该 Codespace 的 `backend/data/` 中；停止/重启会保留，删除 Codespace 会删除其中的本地数据。

GitHub Pages 仅能托管静态前端，无法运行本项目的 SQLite 后端。需要公网分享时，应将完整服务部署到支持 Node.js 24 和持久化磁盘的平台。

可选容器运行：`docker build -t menghua-demo .`，再执行 `docker run --rm -p 3101:3101 -v menghua-data:/app/backend/data menghua-demo`。Dockerfile 已准备；当前云环境未执行容器构建。

## 运行

需要 **Node.js 24 或更高版本**（使用内置 `node:sqlite`），本次验证版本为 24.19.0。
在项目根目录执行，Windows PowerShell、macOS 和 Linux 均使用相同 npm 命令：

```sh
npm ci
npm run build
npm run db:init
npm start
```

前端页面、API 和上传目录由后端统一提供，默认端口为 **3101**。
`npm run db:init` 首次创建演示数据库和本地签名密钥；再次执行会保留已有数据。
已构建的版本可直接执行 `npm run demo`。

## 演示账户与流程

- 超级管理员：`admin` / `123456`
- 质检员：`quality` / `123456`
- 质检负责人：`quality_leader` / `123456`
- 入场员：`admission` / `123456`

这些账户仅用于演示。默认场次包含 40 个货架、717 扎花材，以及质检、配货、打包、冷库和纸箱数据。首次初始化时将原 2026-09-20 主场次平移到当天（Asia/Shanghai）。现有数据库不会在启动时自动改日期；之后可使用场次选择器访问已保存的日期。

建议按以下顺序演示：登录 → 工作台 → 数据中心 → 入场管理 → 花材质检 → 配货大厅 → 纸箱管理 → 冷库暂存。

本次浏览器验证截图与说明见 [云端演示说明](docs/cloud-demo/README.md)。

## 开发与验证

```sh
npm run dev       # H5 开发服务 5174，自动代理 API 到 3101
npm run typecheck
npm run build
npm test
```

测试使用独立临时 SQLite 文件，不改写现有演示库。9 项集成测试覆盖 85 个读取接口、入场写入、库存流水与不足回滚、配货 UPSERT、质检标记与撤销、冷库单次扣减、事务隔离和 SQL 参数处理。

可按日期补充集采、补货及关联仓内演示数据：

```sh
npm run seed:range -- 2026-10-14 2026-10-15
```

该命令重新生成它管理的指定日期测试记录，不用于正式业务数据。单次最多 31 天。

微信小程序构建：`npm run dev:mp-weixin` 或 `npm run build:mp-weixin -w frontend`，需在微信开发者工具验证并配置 AppID。本次只验证 H5。

## 数据与配置

- 默认数据库：`backend/data/menghua.sqlite`
- 上传文件：`backend/uploads/`
- 本地配置：`backend/.env`（自动创建，下载包不包含密钥）
- 可选变量：`SQLITE_PATH`、`HOST`、`PORT`、`AUTH_SECRET`、`CORS_ORIGIN`
- H5 默认使用同源 `/api`，无需在浏览器中配置单独 API 域名。

SQLite 使用 WAL、5 秒 busy timeout 和序列化事务连接。当前业务使用的日期、聚合、JSON、批量参数及 UPSERT 经兼容层处理。`database/sqlite/schema.sql` 和 `data-statements.json` 是生成并验证的初始化文件；运行环境无需 Python。生成器仅在重新转换原始 MySQL SQL 时需要 `sqlglot==27.29.0`。

`database/` 中原有 MySQL SQL 保留为迁移参考。除已改造的 `seed:range` 相关脚本外，原 MySQL 导入维护脚本仍属于历史工具，不应作为 SQLite 初始化方式；服务运行只通过 SQLite 数据层。金额字段使用 SQLite REAL，当前交付用于演示，未验证正式财务结算精度或生产负载。

源码包缺少的 40 个 SVG 图标已按项目规范生成候选替代版本。原商品图片、视频和照片未提供，未还原这些资源。

云环境应复用已有仓库目录（此环境为 `/workspace/tea`），不创建额外 Git worktree。安装与启动说明已保存到环境配置草稿；发布由环境设置界面完成。
