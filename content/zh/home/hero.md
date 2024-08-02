---
widget: hero
headless: true
weight: 10
title: SHUD水文模拟系统
hero_media: hero.png
design:
  background:      
      # Name of image in `assets/media/`.
    image: bg.png
    gradient_angle: 0
    gradient_start: 'rgb(224,223,255)'
    gradient_end: 'rgb(153,238,255)'
    text_color_light: false
cta:
  url: 'https://www.shud.xyz/Book_CN/'
  label: '模型说明书📚'
  icon_pack: fas
cta_alt:
  url:
  label:
cta_note:
  label:
advanced:
  css_class: fullscreen
---

<br>

SHUD(Simulator for Hydrologic Unstructured Domains)是**地表-地下耦合的数值水文模型**。

**非结构化**：非结构三角形为最小水文计算单元。垂直方向分为地表、未饱和层以及饱和层；单元间差异性即反映水文参数的空间异质性。

**可变时间步长**：自适应搜寻保证收敛的时间步长。内部迭代步长为1秒~10分钟。

SHUD模型物理过程清晰、时空分辨率高、适应范围广和扩展性强。模型已经在多个流域得到广泛应用，其流域面积从0.08 $km^2$到12$\times 10^4 km^2$，空间分辨率可以根据需要精确到米级至公里级。在时间尺度上，它能够进行连续模拟，时间跨度从天到百年不等。

SHUD模型在洪水预报、铁路灾害预警、水资源评估、土地利用影响评价、湖泊生态、以及多学科交叉研究中都得到了验证和应用。


<a class="github-button" href="https://github.com/SHUD-System/SHUD" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star Hugo Blox Builder">SHUD模型C++源代码</a>
<br>
<a class="github-button" href="https://github.com/SHUD-System/rSHUD" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star the Online Course template">建模工具rSHUD源代码</a>
<br>
<a class="github-button" href="https://github.com/SHUD-System/AutoSHUD" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star the Online Course template">AutoSHUD自动建模工具</a>
<script async defer src="https://buttons.github.io/buttons.js"></script>
