# Ship of Harkinian 简体中文版 - PortMaster 构建

基于 [Shipwright-CN](https://github.com/wonderfulnx/Shipwright-CN) 的简体中文版 Ship of Harkinian，使用 GitHub Actions 自动构建 PortMaster 移植包。

## 中文版特性

- **中文消息文本** — 2115条来自 iQue ROM 的中文消息
- **中文 UI 纹理** — 动作标签(29)、物品名称(112)、地图标签(34)、地牢标题(10)、地点卡片(57)、Boss卡片(10)
- **CJK 字体** — 2183个自定义 16×16 I4 字形，基于思源黑体
- **HD 纹理包** — 支持 128×128 RGBA32 HD 字形和 UI 纹理

## 构建状态

[![Build SOH Chinese Version](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions/workflows/build.yml/badge.svg)](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions/workflows/build.yml)

## 使用方法

1. 下载最新构建产物：[Actions Artifacts](https://github.com/Windstarry/shipwright_cn_for_portmaster/actions)
2. 将 `soh.zip` 复制到 PortMaster 的 `ports/` 目录
3. 将 OOT ROM 文件放入 `baseroms/` 目录
4. 运行游戏，自动生成资源包
5. 在设置 -> 语言中选择中文

## HD 纹理

如需 HD 中文纹理，运行以下命令生成：

```bash
cd scripts/chinese
uv run message/generate_assets.py
uv run message/generate_hd_font_o2r.py
uv run hd_textures/generate_hd_menu_o2r.py
```

然后将生成的 `chinese_font_hd.o2r` 和 `chinese_menu_hd.o2r` 放入 `mods/` 文件夹。

## 致谢

- [wonderfulnx/Shipwright-CN](https://github.com/wonderfulnx/Shipwright-CN) - 中文本地化
- [HarbourMasters/Shipwright](https://github.com/HarbourMasters/Shipwright) - 原版 SOH
- [PortMaster](https://github.com/PortsMaster/PortMaster) - 移植平台
