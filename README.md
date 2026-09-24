# Ship of Harkinian 简体中文版 - PortMaster 构建

基于 [Windstarry/Shipwright-CN](https://github.com/Windstarry/Shipwright-CN)（分支 `cn`，版本 9.2.3-cn-rc2）的简体中文版 Ship of Harkinian，使用 GitHub Actions 自动构建 PortMaster 移植包。

[![Build SOH Chinese Version](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions/workflows/build.yml/badge.svg)](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions/workflows/build.yml)

## 下载

从 [Releases](https://github.com/Windstarry/shipwright_cn_for_portmaster/releases) 页面下载最新版本。

| 文件 | 说明 |
|------|------|
| soh.zip | PortMaster 安装包（推荐） |
| soh-linux-x86_64.tar.gz | x86_64 单独构建 |
| soh-linux-aarch64.tar.gz | aarch64 单独构建 |

## 中文版特性

- **中文消息文本** - 2115条来自 iQue ROM 的中文消息
- **中文 UI 纹理** - 动作标签(29)、物品名称(112)、地图标签(34)、地牢标题(10)、地点卡片(57)、Boss卡片(10) 等
- **CJK 字体** - 2183个自定义 16x16 I4 字形，基于思源黑体
- **HD 纹理包** - 支持 128x128 RGBA32 HD 字形和 UI 纹理
- **ImGui 设置菜单简体中文** - 移植菜单 / 设置界面可切换英文或中文（`Menu Language`）；菜单汉化移植自 **Shipwright-cn-XPlat-cel-cn-menu** 项目

## 安装方法

1. 将 soh.zip 解压到 PortMaster 的 ports/ 目录
2. 将 OOT ROM 文件（.z64/.n64）放入 baseroms/ 目录
3. 运行游戏，自动生成资源包
4. **游戏文本**：设置 → 语言 中选择中文
5. **菜单界面**：设置 → Languages → **Menu Language（菜单语言）** 选择 中文（可与游戏文本语言独立切换）

## 自动构建

每次推送到 master 分支或手动触发工作流时，GitHub Actions 会自动：

1. 构建 x86_64 和 aarch64 版本（源：`Windstarry/Shipwright-CN` @ `cn`）
2. 打包为 PortMaster 格式
3. 提交构建结果
4. 创建 GitHub Release 并上传产物

## 手动触发构建

1. 打开 [Actions](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions/workflows/build.yml)
2. 点击 Run workflow
3. 选择参数后点击 Run workflow

## HD 纹理

如需 HD 中文纹理，运行以下命令生成：

```
cd scripts/chinese
uv run message/generate_assets.py
uv run message/generate_hd_font_o2r.py
uv run hd_textures/generate_hd_menu_o2r.py
```

然后将生成的 chinese_font_hd.o2r 和 chinese_menu_hd.o2r 放入 mods/ 文件夹。

## 项目结构

```
shipwright_cn_for_portmaster/
  .github/
    docker/          Docker 构建环境
    workflows/       GitHub Actions 工作流
  recipes/ports/soh/   构建配方
  ports/soh/soh/       游戏文件（构建后填充）
  .gitattributes       Git LFS + LF 换行符配置
  README.md
```

## 致谢

- [Windstarry/Shipwright-CN](https://github.com/Windstarry/Shipwright-CN)（`cn`）- 简体中文游戏文本 / 纹理 / 字体
- **Shipwright-cn-XPlat-cel-cn-menu** - ImGui 设置菜单汉化（`Localization` / `Menu Language`）移植来源
- [wonderfulnx/Shipwright-CN](https://github.com/wonderfulnx/Shipwright-CN) - 早期简体中文基础
- [HarbourMasters/Shipwright](https://github.com/HarbourMasters/Shipwright) - 原版 SOH
- [PortMaster](https://github.com/PortsMaster/PortMaster) - 移植平台
