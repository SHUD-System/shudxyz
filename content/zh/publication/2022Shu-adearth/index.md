+++
title = "SHUD数值方法分布式水文模型介绍"
date = 2022-07-12T00:00:00

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["舒乐乐", "常燕", "王建", "陈昊", "李照国", "赵林", "孟宪红"]


# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference paper
# 2 = Journal article
# 3 = Manuscript
# 4 = Report
# 5 = Book
# 6 = Book section
publication_types = ["2"]

# Publication name and optional abbreviated version.
publication = "地球科学进展"
publication_short = "地球科学进展"

# Abstract.
abstract = "水文模型是高效且经济的科学实验工具，不仅能结合观测数据验证科学理论、指导观测网络布设，而且对社会水资源管理、灾害防治以及经济决策等有不可或缺的重要价值。数值方法水文模型依据达西定律、理查兹方程和圣维南方程等水文物理公式，充分表现水文参数空间异质性，精细化表达水文物理过程，是水文模型发展的重要方向之一。SHUD作为地表—地下耦合的数值方法分布式水文模型，具有多尺度、多过程、高时间分辨率和灵活空间分辨率的特点，其物理过程表达更接近真实、综合运算效率高、模拟精度好，在全球若干流域的应用研究已初步验证了模型的有效性和适用性。SHUD模型源码公开，支持源码修改和重发布，是对水文模拟方法的贡献，也是水文模型中具有强发展潜力的成果之一。集合SHUD模型、rSHUD工具和全球公开基础地理数据组成的AutoSHUD自动化水文模拟系统，已应用于多项学科"

# Summary. An optional shortened abstract.

# summary = ""

# Digital Object Identifier (DOI)
doi = "10.1360/SSTe-2022-0420"

# Is this a featured publication? (true/false)
featured = true

# Tags (optional).
#   Set `tags = []` for no tags, or use the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["News", "Website", "SHUD", "水文模型"]

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["deep-learning"]` references
#   `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects = ["internal-project"]

# Links (optional).
# url_pdf = ""
# url_preprint = ""
# url_code = "#"
# url_dataset = "#"
# url_project = ""
# url_slides = "#"
# url_video = "#"
# url_poster = "#"
# url_source = "#"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
# links = [{name = "Custom Link", url = "http://example.org"}]

# Does this page contain LaTeX math? (true/false)
math = false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++
考虑到冰冻圈、生态系统、环境化学对能量—水分循环的直接影响，数值方法模型需深入探索“冰冻圈—水文—生态—环境化学”紧密耦合的集成模型，以便更好地理解气候变化和人类活动影响下的水资源和水循环响应，为国家生态文明建设提供科学支撑。ParFlow v3.5探索了CLM陆面过程模型（Community Land Model）与数值水文模型ParFlow的紧密耦合［48］，开拓了模型耦合的新思路。

地表—地下耦合的数值方法水文模型的研发面临的关键挑战在于：①有限计算能力与时空分辨率的无限要求之间的矛盾；②模型对大数量和高质量物理参数的要求与有限观测手段和观测覆盖范围之间的矛盾；③模型需要多尺度、多问题的应用测试的需求与有限验证数据之间的矛盾；④精细的多物理过程表达与关键变量快速模拟响应之间的矛盾。模型研发工作结合水文、数学、工程和计算机领域的进展，也需要人才、经费和时间方面的巨大投入。以ParFlow模型［20，49-50］为例，该模型由美国普林斯顿大学、科罗拉多矿业大学、华盛顿州立大学、雪城大学、劳伦斯—利佛摩国家实验室、德国的伯恩大学、利希研究中心、地球系统超算中心和法国地球环境研究所等多家大学和研究机构共同参与研发（https：//parflow.org/#team），足见其研究的重要性和研发难度。

当前我国科学家在概念水文模型和大尺度分布式水文模型方面已有较多原创性成果，但是对数值方法分布式水文模型的探讨、开发和应用都较为薄弱，亟需在此领域进行更多原创性探索。在模型应用方面，根据知网关键词搜索结果，SWAT、VIC和TopModel等传统模型为关键词的文献数量分别约为2 700篇、700篇和300篇，但是以MIKE SHE为关键词的文献搜索结果数量则小于100篇，其他数值方法水文模型的中文文献数量则接近或等于0篇。因此，未来我国在水文研究领域，不仅需要支持新模型研发，同时需丰富已有模型在全球不同区域和应用需求的验证、推广和改进工作。

![公式](eq.png)

![SHUD模型输出文件](output.png)


**How to cite.**  舒乐乐，常燕，王建，等.SHUD数值方法分布式水文模型介绍[J].地球科学进展，2022，37(7):680-691. DOI:10.11867/j.issn.1001-8166.2022.025[.SHU Lele，CHANG Yan，WANG Jian，et al. A brief review of numerical distributed hydrological model SHUD[J]. Advances in Earth Science，2022，37(7):680-691. DOI:10.11867/j.issn.1001-8166.2022.025.]
