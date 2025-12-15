# 建模基本方法论 {#ch1_modeling}

本章介绍数值方法建模的基本方法论，涉及一些基础的建模思路和数学基础。



## 建模基本思路

我称之为CLAMS方法，包含以下步骤：

1. **C**onceptual Model - 描述物理过程，形成概念模型（或认知模型）
1. **L**aws of Physics - 使用物理规律
1. **A**ssumptions - 列出合理假设，简化问题
1. **M**ath equations - 使用数学公式表达物理规律和假设
1. **S**olver - 求解数学公式


求解数学公式的过程，可以尝试寻找其解析解(Analytical solution)，也可以使用数值方法求得数值解(Numerical Solution)。

数值方法本质上是对离散（非连续）时空模型中因变量(Dependant variable)分布和变化的数学近似描述，从理论的解析解到数值解虽然损失了精度，但解析解通常无法求得，而数值方法可给出误差可接受的近似解。

### CLAMS方法应用案例：**落体运动**{-}

**描述** 
问题描述下图。

![落体运动示意图](image/ch1/FallingObj/FallingObj.001.jpeg)

**问题**：任意$t>0$时刻的速度，即$v(t) = ?$。

建模步骤：

1. **认知模型**： 

    落体运动(Fall motion): 落体运动是指物体在重力作用下从一定高度自由下落的运动。

    当考虑风阻时，物体的运动会受到空气阻力的影响，这种阻力通常与物体的速度、形状、大小以及空气的密度有关。在实际的落体运动中，空气阻力会对物体的速度产生显著影响，主要体现在以下几个方面：

    减小物体的加速度：在自由落体运动中，如果不考虑空气阻力，物体将以恒定的加速度（重力加速度）下落。但当考虑空气阻力时，物体受到的合外力将不再等于其重力，导致物体的净加速度减小。根据牛顿第二定律，物体的净加速度等于合外力除以物体的质量。因此，空气阻力的存在会导致物体的速度增长速度减慢。
    
    使物体达到终端速度：随着物体下落速度的增加，空气阻力也会增大，直到与重力相平衡。此时，物体的速度不再增加，达到一个恒定值，这个速度称为终端速度。终端速度取决于物体的形状、大小以及空气的密度。一般来说，形状较大、大小较小的物体终端速度较小，而形状较小、大小较大的物体终端速度较大。
    
    影响物体的下落轨迹：空气阻力不仅影响物体的速度，还可能影响物体的下落轨迹。例如，在北半球自由落体运动中，空气阻力可能导致物体的偏离，使得落体运动的轨迹发生偏移。
    
    在实际应用中，如汽车空气动力学研究，风阻是一个重要的考虑因素。通过风洞实验和数值计算，可以研究模型周围流动的物理特征，理解气动力产生机理，研究气动力控制方法等。这些研究有助于优化汽车等物体的设计，以减少风阻、提高效率。
    
    总的来说，考虑风阻的落体运动是一个复杂的物理过程，涉及到流体力学、物体的动力学特性以及环境因素等多个方面。通过实验和理论分析，可以更准确地描述和预测物体在实际环境中的运动行为。
    
2. **物理定律**： 

    牛顿定律： $F = ma$。
    
    牛顿第二定律的描述是：物体的加速度与作用在物体上的合外力成正比，与物体的质量成反比，且加速度的方向与合外力的方向相同。牛顿第二定律是经典力学中描述物体运动的基本定律之一，由艾萨克·牛顿在1687年出版的《自然哲学的数学原理》中提出。
    
3. **假设**： 

    - 假设1：$v(t=0) = 0$ 
    - 假设2：$F_{drag}(t) \propto v(t)$，即$F_{drag} = cv$。
    
    假设1属于初始条件，即进行计算最一开始的系统状态，基于这个“初始状态”系统开始变化。 假设2属于系统内过程的假设，这里假设了风的阻力与运动速度的一次方成正比。我们其实也可以假设风阻力与速度的二次方成正比，这一假设在实际应用中更常见。
    
4. **数学公式**： 
    
    由$F = ma$和$\frac{dv}{dt} = a$可得：
    
    $$\tag{1} \frac{dv}{dt} = a = \frac{F}{m}$$
    
    根据物体受力分析, 其受到向下的重力$F_{g} = mg$和向上的空气阻力$F_{drag} = cv$，空气阻力在此假设与物体运动速度成正比关系。则其受力平衡公式为：
    $$\tag{2} F = F_{g} - F_{drag} = mg - cv$$
    
    综合公式（1）和（2），则得到：
    $$\tag{3} \frac{dv}{dt} = g - \frac{c}{m} v$$
    
    ![自由落体运动的受力分析](image/ch1/FallingObj/FallingObj.002.jpeg)

5. **公式求解**：

    初始条件：$v(0) = 0$
    
    积分求解(解析解)：
    $$v(t) = \frac {mg}{c}\left[ 1- exp(-\frac{c}{m}t) \right]$$
6. **结果绘图**：


```r
c = 15 # drag coeefficient
g = 9.8 # Gravity
m = 150  # Mass in kg
x = seq(0,100, 1)  # Time
y = m*g/c *(1 - exp(-1 * c / m * x))  # Vecocity
plot(x, y, type='l', xlab='Time (s)', ylab='Velocity (m/s)', col=2, lwd=2); 
grid()
```

<div class="figure" style="text-align: center">
<img src="_bookdown_files/01-Modeling_files/figure-html/example_falling_obj-1.png" alt="自由落体运动速度随时间变化曲线" width="60%" />
<p class="caption">(\#fig:example_falling_obj)自由落体运动速度随时间变化曲线</p>
</div>


*变量表:*

- $v(t)$ - 随时间变化的物体速度
- $m$ - 物体质量
- $g$ - 重力加速度
- $a$ - 物体运动的加速度
- $c$ - 空气阻力系数 
- $F$ - 物体所受的力
- $F_{g}$ - 重力
- $F_{drag}$ - 空气阻力



### 落体运动的数值求解方法

前一节我们使用了解析解对落体运动进行了求解。但是现实中很多问题很难寻找的解析解，但是可以通过不同的数值方法和计算方案得到所需时间和空间上某一变量的数值解，数值解是解析解的近似。

针对以上的落体运动，我们首先跳过CLAMS方法的前4步，我们使用数值方法来完成Solver这个步骤。

#### 求解数学公式(Solver)

- 初始条件：$v(0) = 0$
- 控制方程：$$\frac{dv}{dt} = g - \frac{c}{m} v$$
- 根据极限理论，当时间不长无限趋近于0时，我们可以根据前一时刻的系统状态（状态），和此时的变化趋势（导数）计算出相邻时刻的系统状态（未来状态）。 则： $$v_{t+1} = v_{t} + \frac{dv}{dt} * \Delta t$$
    更进一步，可得到：$$v_{t+1} = v_{t} + [g - \frac{c}{m} \cdot v_{t}]* \Delta t$$
    
我们可以在Excel中进行如下计算。



| Step | Time | V_t    | dV/dt   | V_t+1   | V_analytic | Error    | ERROR %         |
|------|------|--------|---------|---------|-----------|---------|----------------|
| 1 | 0 | 0.0000 | 4.9000 | 4.9000 | 0.0000 | 0.0000 | 0 |
| 2 | 0.5 | 4.9000 | 4.6550 | 9.5550 | 4.7795 | 0.1205 | 0.025208325 |
| 3 | 1 | 9.5550 | 4.4223 | 13.9773 | 9.3259 | 0.2291 | 0.024562365 |
| 4 | 1.5 | 13.9773 | 4.2011 | 18.1784 | 13.6506 | 0.3266 | 0.023927978 |
| 5 | 2 | 18.1784 | 3.9911 | 22.1695 | 17.7644 | 0.4140 | 0.023305128 |
| 6 | 2.5 | 22.1695 | 3.7915 | 25.9610 | 21.6775 | 0.4919 | 0.022693776 |
| 7 | 3 | 25.9610 | 3.6020 | 29.5629 | 25.3998 | 0.5612 | 0.022093876 |
| 8 | 3.5 | 29.5629 | 3.4219 | 32.9848 | 28.9406 | 0.6224 | 0.021505376 |
| 9 | 4 | 32.9848 | 3.2508 | 36.2356 | 32.3086 | 0.6762 | 0.02092822 |
| 10 | 4.5 | 36.2356 | 3.0882 | 39.3238 | 35.5124 | 0.7231 | 0.020362349 |
| ... | ... |  |  |  |  |  |  |
| ... | ... |  |  |  |  |  |  |

使用R进行计算结果为：

```r
c = 15 # drag coeefficient
g = 9.8 # Gravity
m = 150  # Mass in kg
dt = 0.1
x = seq(0,100, dt)  # Time

# Analytic solution
y = m*g/c *(1 - exp(-1 * c / m * x))  # Vecocity

# Numeric solution
nx= length(x)
y_ana = rep(NA, nx)
y_ana[1]=0
for(i in 2:nx){
  dydt = g - c / m * y_ana[i-1]
  y_ana[i] = y_ana[i-1] + dydt * dt
}

df = data.frame('Time'=x, 'V'=y, 'V_ana'=y_ana)
par(mfrow=c(2, 1), mar=c(3, 3, 1,0))
matplot(x, cbind(y, y_ana), type='l', xlab='Time (s)', ylab='Velocity (m/s)', 
        col=1:2, lwd=2, lty=1:2); grid()
legend('bottomright', c('Analytic', 'Numeric'), col=1:2, lwd=2, lty=1:2)
grid()

plot(abs(y - y_ana));
mtext('Error', side=3, line=-2, font=2, cex=2)
grid()
```

<img src="_bookdown_files/01-Modeling_files/figure-html/unnamed-chunk-1-1.png" width="672" />


## 解析解与数值解

数值解(Numeric solution)和解析解(Analytic solution)是解决科学和工程问题时得到的两种不同类型的解。它们的主要区别在于解的形式和求解过程：

1. **形式上的区别**：
   - **解析解**：通常是一个精确的数学表达式，可以是一个公式、方程或者函数。解析解能够给出问题的完整描述，包括所有的细节和特性。
   - **数值解**：是一个近似值，通常是一个数字或者一组数字。数值解是通过数值方法在计算机上计算得到的，只能近似地表示问题的解。

2. **求解过程的区别**：
   - **解析解**：通过数学推导和符号运算得到。这种方法通常需要对问题进行简化和抽象，以便于找到精确的数学表达式。
   - **数值解**：通过数值算法和计算机程序实现。数值方法不需要对问题进行简化，而是直接在计算机上模拟问题的物理过程，通过迭代和逼近来获得解。

3. **精确度**：
   - **解析解**：是精确的，没有误差，可以提供问题的完整信息。
   - **数值解**：是近似的，存在一定的误差。这种误差可能来源于数值方法的离散化、舍入误差等。

4. **适用性**：
   - **解析解**：适用于那些可以找到精确数学表达式的问题。解析解在理论上非常有价值，因为它们提供了对问题的深入理解。
   - **数值解**：适用于那些难以找到解析解的复杂问题，或者解析解过于复杂难以直接使用的情况。数值解在工程和科学实践中非常常见，因为它们可以处理实际问题中的复杂性和不确定性。

5. **计算成本**：
   - **解析解**：一旦找到，计算成本通常很低，因为解析解可以直接用于计算。
   - **数值解**：可能需要较高的计算成本，尤其是在需要高精度解或者问题规模很大时。

6. **通用性**：
   - **解析解**：通常具有很好的通用性，因为它们是精确的数学表达式，可以应用于各种情况。
   - **数值解**：可能需要针对具体问题调整数值方法和参数，以获得更好的近似效果。


简洁地总结了数值解和解析解在不同方面的主要区别。

| 特性       | 数值解                           | 解析解                           |
|----------|-------------------------------|------------------------------|
| **形式**      | 近似值，通常是一个数字或一组数字。 | 精确的数学表达式，如公式、方程或函数。 |
| **求解过程**    | 通过数值算法和计算机程序实现。       | 通过数学推导和符号运算得到。         |
| **精确度**      | 近似，存在误差。                   | 精确，没有误差。                     |
| **适用性**      | 适用于难以找到解析解的复杂问题。       | 适用于可以找到精确数学表达式的问题。   |
| **计算成本**    | 可能需要较高的计算成本。             | 一旦找到，计算成本通常很低。           |
| **通用性**      | 需要针对具体问题调整数值方法和参数。 | 具有很好的通用性，可以直接用于计算。   |


总的来说，解析解和数值解各有优势和局限，选择哪种解法取决于问题的性质、求解的精度要求以及可用的计算资源。在实际应用中，数值解因其灵活性和适用性而被广泛使用。




## 典型控制方程

### 一维承压地下水运动
Sure, let's derive the governing equation for one-dimensional confined aquifer groundwater flow step by step. We will use Darcy's Law and the principle of mass conservation.

#### Step 1: Darcy's Law
Darcy's Law describes the flow of groundwater through porous media. It states that the discharge per unit area (specific discharge or Darcy velocity, $q$) is proportional to the hydraulic gradient:
$$q = -K \frac{\partial h}{\partial x}$$
where:
- $q$ is the specific discharge (Darcy velocity) [L/T].
- $K$ is the hydraulic conductivity of the aquifer [L/T].
- $h$ is the hydraulic head [L].
- $x$ is the spatial coordinate in the direction of flow [L].

#### Step 2: Conservation of Mass
Consider a control volume of length $\Delta x$, cross-sectional area $A$, and located at position $x$ along the direction of flow within a confined aquifer.

##### Inflow and Outflow
- The rate of inflow at $x$: $q(x) \cdot A$.
- The rate of outflow at $ x + \Delta x $: $q(x + \Delta x) \cdot A$.

Using a Taylor series expansion for $q(x + \Delta x)$:
$$q(x + \Delta x) \approx q(x) + \left( \frac{\partial q}{\partial x} \right) \Delta x$$

##### Net Flow
The net rate of flow into the control volume is:
$$q(x) \cdot A - \left( q(x) + \left( \frac{\partial q}{\partial x} \right) \Delta x \right) \cdot A$$
$$= -A \left( \frac{\partial q}{\partial x} \right) \Delta x$$

#### Step 3: Storage in the Aquifer
The change in storage within the control volume over a time interval $\Delta t$ can be expressed using the specific storage $S_s$, which is the amount of water per unit volume of the aquifer that is stored or released from storage per unit change in hydraulic head:
$$\Delta S = S_s \cdot A \cdot \Delta x \cdot \frac{\partial h}{\partial t} \cdot \Delta t$$

#### Step 4: Applying Conservation of Mass
According to the conservation of mass principle, the rate of change of storage in the control volume must equal the net rate of flow into the control volume:
$$-A \left( \frac{\partial q}{\partial x} \right) \Delta x = S_s \cdot A \cdot \Delta x \cdot \frac{\partial h}{\partial t}$$

#### Step 5: Substituting Darcy's Law
Substitute $q = -K \frac{\partial h}{\partial x}$ into the equation:
 $$-A \left( \frac{\partial}{\partial x} \left( -K \frac{\partial h}{\partial x} \right) \right) \Delta x = S_s \cdot A \cdot \Delta x \cdot \frac{\partial h}{\partial t}$$
  
  Simplify the equation:
 $$A \left( K \frac{\partial^2 h}{\partial x^2} \right) \Delta x = S_s \cdot A \cdot \Delta x \cdot \frac{\partial h}{\partial t}$$
  
  #### Step 6: Simplifying and Rearranging
  Cancel out the common terms $A$ and $\Delta x$:
 $$K \frac{\partial^2 h}{\partial x^2} = S_s \frac{\partial h}{\partial t}$$
  
  #### Final Governing Equation
  The one-dimensional groundwater flow equation for a confined aquifer is:
 $$\frac{\partial h}{\partial t} = \frac{K}{S_s} \frac{\partial^2 h}{\partial x^2}$$
  
  Define the hydraulic diffusivity $D$ as:
 $$D = \frac{K}{S_s}$$
  
  Thus, the governing equation can also be written as:
 $$\frac{\partial h}{\partial t} = D \frac{\partial^2 h}{\partial x^2}$$
  
  This partial differential equation describes how the hydraulic head $h$ varies with time $t$ and position $x$ within the confined aquifer.
  
### 二维承压地下水运动

Sure, let's derive the governing equation for two-dimensional confined aquifer groundwater flow step by step using Darcy's Law and the principle of mass conservation.

#### Step 1: Darcy's Law
In two dimensions, Darcy's Law describes the flow of groundwater through porous media. It states that the discharge per unit area (specific discharge or Darcy velocity, $\mathbf{q}$) is proportional to the hydraulic gradient:
$$\mathbf{q} = -K \nabla h$$
where:
- $\mathbf{q}$ is the specific discharge (Darcy velocity) vector [L/T].
- $K$ is the hydraulic conductivity of the aquifer [L/T].
- $h$ is the hydraulic head [L].
- $\nabla h$ is the hydraulic gradient, which in two dimensions can be written as:
 $$\nabla h = \left( \frac{\partial h}{\partial x}, \frac{\partial h}{\partial y} \right)$$

#### Step 2: Conservation of Mass
Consider a differential control volume in the aquifer with dimensions $dx$ by $dy$ and thickness $b$.

##### Inflow and Outflow
For simplicity, let's assume the flow is in the $x$- and $y$-directions.

- The rate of inflow in the $x$-direction at $x$: $ q_x(x) \cdot b \cdot dy $
  - The rate of inflow in the $y$-direction at $y$: $ q_y(y) \cdot b \cdot dx $
  
  The rate of outflow in the $x$-direction at $x + dx$:
 $$q_x(x + dx) \cdot b \cdot dy \approx \left( q_x(x) + \frac{\partial q_x}{\partial x} dx \right) \cdot b \cdot dy$$
  
  The rate of outflow in the $y$-direction at $y + dy$:
 $$q_y(y + dy) \cdot b \cdot dx \approx \left( q_y(y) + \frac{\partial q_y}{\partial y} dy \right) \cdot b \cdot dx$$
  
  ##### Net Flow
  The net rate of flow into the control volume is:
 $$\text{Net inflow in } x\text{-direction} = \left[ q_x(x) \cdot b \cdot dy \right] - \left[ \left( q_x(x) + \frac{\partial q_x}{\partial x} dx \right) \cdot b \cdot dy \right]$$
 $$= -b \cdot dy \cdot \frac{\partial q_x}{\partial x} dx$$
  
 $$\text{Net inflow in } y\text{-direction} = \left[ q_y(y) \cdot b \cdot dx \right] - \left[ \left( q_y(y) + \frac{\partial q_y}{\partial y} dy \right) \cdot b \cdot dx \right]$$
 $$= -b \cdot dx \cdot \frac{\partial q_y}{\partial y} dy$$
  
  The total net inflow into the control volume is:
 $$-b \left( \frac{\partial q_x}{\partial x} dx \cdot dy + \frac{\partial q_y}{\partial y} dy \cdot dx \right)$$
 $$= -b \left( \frac{\partial q_x}{\partial x} + \frac{\partial q_y}{\partial y} \right) dx \cdot dy$$
  
  #### Step 3: Storage in the Aquifer
  The change in storage within the control volume over a time interval $\Delta t$ can be expressed using the specific storage $S_s$:
 $$\Delta S = S_s \cdot b \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t} \cdot \Delta t$$
  
  #### Step 4: Applying Conservation of Mass
  According to the conservation of mass principle, the rate of change of storage in the control volume must equal the net rate of flow into the control volume:
 $$-b \left( \frac{\partial q_x}{\partial x} + \frac{\partial q_y}{\partial y} \right) dx \cdot dy = S_s \cdot b \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t}$$
  
  #### Step 5: Substituting Darcy's Law
  Substitute $q_x = -K \frac{\partial h}{\partial x}$ and $q_y = -K \frac{\partial h}{\partial y}$ into the equation:
 $$-b \left( \frac{\partial}{\partial x} \left( -K \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( -K \frac{\partial h}{\partial y} \right) \right) dx \cdot dy = S_s \cdot b \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t}$$
  
  Simplify the equation:
 $$b \left( K \frac{\partial^2 h}{\partial x^2} + K \frac{\partial^2 h}{\partial y^2} \right) dx \cdot dy = S_s \cdot b \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t}$$
  
  #### Step 6: Simplifying and Rearranging
  Cancel out the common terms $b$, $dx$, and $dy$:
 $$K \left( \frac{\partial^2 h}{\partial x^2} + \frac{\partial^2 h}{\partial y^2} \right) = S_s \frac{\partial h}{\partial t}$$
  
  #### Final Governing Equation
  The two-dimensional groundwater flow equation for a confined aquifer is:
 $$\frac{\partial h}{\partial t} = \frac{K}{S_s} \left( \frac{\partial^2 h}{\partial x^2} + \frac{\partial^2 h}{\partial y^2} \right)$$
  
  Define the hydraulic diffusivity $D$ as:
 $$D = \frac{K}{S_s}$$
  
  Thus, the governing equation can also be written as:
 $$\frac{\partial h}{\partial t} = D \left( \frac{\partial^2 h}{\partial x^2} + \frac{\partial^2 h}{\partial y^2} \right)$$
  
  This partial differential equation describes how the hydraulic head $h$ varies with time $t$ and position $(x, y)$ within the confined aquifer.

### 一维非承压地下水运动

Let's go through the derivation for one-dimensional unconfined aquifer groundwater flow more carefully, considering the variation in aquifer thickness due to changes in the water table.

#### Step-by-Step Derivation for One-Dimensional Unconfined Aquifer

#### Step 1: Darcy's Law

For unconfined groundwater flow, Darcy's Law in one dimension is:
$$q = -K \frac{\partial h}{\partial x}$$
where:
- $q$ is the specific discharge (Darcy velocity) [L/T].
- $K$ is the hydraulic conductivity of the aquifer [L/T].
- $h$ is the hydraulic head [L].
- $x$ is the spatial coordinate in the direction of flow [L].

#### Step 2: Volumetric Flow Rate

The volumetric flow rate $Q$ at a point $x$ for an unconfined aquifer with variable saturated thickness $h$ is given by:
$$Q = q \cdot b \cdot h$$
where $b$ is the aquifer width perpendicular to the flow direction. For simplicity, we assume $ b = 1 $ unit width, leading to:
$$Q = q \cdot h = -K h \frac{\partial h}{\partial x}$$

#### Step 3: Conservation of Mass

Consider a differential control volume in the unconfined aquifer of width $dx$ and saturated thickness $ h(x) $.

##### Inflow and Outflow
- Inflow at $x$: $Q(x) = -K h \frac{\partial h}{\partial x}$
- Outflow at $x + dx$: $Q(x + dx) = -K h \frac{\partial h}{\partial x} + \left( \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) \right) dx$

##### Net Flow
The net inflow into the control volume is:
$$Q(x) - Q(x + dx) = -K h \frac{\partial h}{\partial x} - \left( -K h \frac{\partial h}{\partial x} + \left( \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) \right) dx \right)$$
$$= - \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx$$

#### Step 4: Change in Storage

The change in storage within the control volume $ dx \cdot h $ over a time interval $ \Delta t $ can be expressed using the specific yield $S_y$, which measures the volume of water released from storage per unit decline in the water table:
$$\Delta S = S_y \cdot dx \cdot \frac{\partial h}{\partial t} \cdot \Delta t$$

#### Step 5: Applying Conservation of Mass

According to the conservation of mass principle, the rate of change of storage in the control volume must equal the net rate of flow into the control volume:
$$- \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx = S_y \cdot dx \cdot \frac{\partial h}{\partial t}$$

#### Step 6: Simplifying and Rearranging

Simplify the equation:
$$\frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right) = S_y \frac{\partial h}{\partial t}$$

#### Final Governing Equation

The one-dimensional groundwater flow equation for an unconfined aquifer is:
$$S_y \frac{\partial h}{\partial t} = \frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right)$$

This is the governing equation for transient groundwater flow in an unconfined aquifer. It accounts for changes in the saturated thickness $h$ due to fluctuations in the water table.

### 二维非承压地下水运动
Sure, let's derive the governing equation for two-dimensional unconfined aquifer groundwater flow step by step. We'll again use Darcy's Law, the principle of mass conservation, and the Dupuit assumption, which simplifies the analysis by assuming horizontal flow and a vertical hydraulic gradient.

#### Step-by-Step Derivation for Two-Dimensional Unconfined Aquifer

#### Step 1: Darcy's Law

In two dimensions, Darcy's Law for an unconfined aquifer can be written as:

$$\mathbf{q} = -K \nabla h$$

where:
- $\mathbf{q}$ is the specific discharge (Darcy velocity) vector [L/T].
- $K$ is the hydraulic conductivity of the aquifer [L/T].
- $h$ is the hydraulic head [L].
- $\nabla h$ is the hydraulic gradient, which in two dimensions can be written as:
 $$\nabla h = \left( \frac{\partial h}{\partial x}, \frac{\partial h}{\partial y} \right)$$

#### Step 2: Volumetric Flow Rate

For a control volume in the unconfined aquifer, the volumetric flow rate $Q$ at a point in two dimensions is given by:

$$Q_x = q_x \cdot h = -K h \frac{\partial h}{\partial x}$$
$$Q_y = q_y \cdot h = -K h \frac{\partial h}{\partial y}$$

where $h$ is the saturated thickness of the aquifer.

#### Step 3: Conservation of Mass

Consider a differential control volume in the unconfined aquifer with dimensions $dx$ by $dy$ and saturated thickness $h$.

##### Inflow and Outflow
- Inflow in the $x$-direction at $x$: $Q_x(x) = -K h \frac{\partial h}{\partial x}$
- Outflow in the $x$-direction at $x + dx$: $Q_x(x + dx) = -K h \frac{\partial h}{\partial x} + \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx$

- Inflow in the $y$-direction at $y$: $Q_y(y) = -K h \frac{\partial h}{\partial y}$
- Outflow in the $y$-direction at $y + dy$: $Q_y(y + dy) = -K h \frac{\partial h}{\partial y} + \frac{\partial}{\partial y} \left( -K h \frac{\partial h}{\partial y} \right) dy$

##### Net Flow
The net inflow into the control volume is:

$$\text{Net inflow in } x\text{-direction} = Q_x(x) - Q_x(x + dx)$$
$$= -K h \frac{\partial h}{\partial x} - \left( -K h \frac{\partial h}{\partial x} + \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx \right)$$
$$= - \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx$$

$$\text{Net inflow in } y\text{-direction} = Q_y(y) - Q_y(y + dy)$$
$$= -K h \frac{\partial h}{\partial y} - \left( -K h \frac{\partial h}{\partial y} + \frac{\partial}{\partial y} \left( -K h \frac{\partial h}{\partial y} \right) dy \right)$$
$$= - \frac{\partial}{\partial y} \left( -K h \frac{\partial h}{\partial y} \right) dy$$

The total net inflow into the control volume is:

$$\text{Net inflow} = - \left( \frac{\partial}{\partial x} \left( -K h \frac{\partial h}{\partial x} \right) dx + \frac{\partial}{\partial y} \left( -K h \frac{\partial h}{\partial y} \right) dy \right)$$
$$= \left( \frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right) dx + \frac{\partial}{\partial y} \left( K h \frac{\partial h}{\partial y} \right) dy \right)$$

#### Step 4: Change in Storage

The change in storage within the control volume over a time interval $\Delta t$ can be expressed using the specific yield $S_y$, which is the volume of water released from storage per unit surface area per unit decline in the water table:

$$\Delta S = S_y \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t} \cdot \Delta t$$

#### Step 5: Applying Conservation of Mass

According to the conservation of mass principle, the rate of change of storage in the control volume must equal the net rate of flow into the control volume:

$$\frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right) dx + \frac{\partial}{\partial y} \left( K h \frac{\partial h}{\partial y} \right) dy = S_y \cdot dx \cdot dy \cdot \frac{\partial h}{\partial t}$$

#### Step 6: Simplifying and Rearranging

Divide through by $ dx \cdot dy $:

$$\frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K h \frac{\partial h}{\partial y} \right) = S_y \frac{\partial h}{\partial t}$$

#### Final Governing Equation

The two-dimensional groundwater flow equation for an unconfined aquifer is:

$$S_y \frac{\partial h}{\partial t} = \frac{\partial}{\partial x} \left( K h \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K h \frac{\partial h}{\partial y} \right)$$

This is the governing equation for transient groundwater flow in a two-dimensional unconfined aquifer. It accounts for the variation in the saturated thickness $h$ due to fluctuations in the water table and assumes horizontal flow and a vertical hydraulic gradient, as per the Dupuit approximation.

### 三维非承压地下水运动
You are right. The Dupuit assumption is primarily applicable to simplifying two-dimensional flow problems in unconfined aquifers by assuming horizontal flow and neglecting vertical gradients. For a three-dimensional unconfined aquifer groundwater flow, we need to take a different approach that does not rely on the Dupuit assumption.

Let's derive the governing equation for three-dimensional unconfined aquifer groundwater flow without using the Dupuit assumption, considering the changes in storage and flow in all three dimensions properly.

#### Step-by-Step Derivation for Three-Dimensional Unconfined Aquifer

#### Step 1: Darcy's Law

In three dimensions, Darcy's Law for groundwater flow in an unconfined aquifer is given by:

$$\mathbf{q} = -K \nabla h$$

where:
- $\mathbf{q}$ is the specific discharge (Darcy velocity) vector [L/T].
- $K$ is the hydraulic conductivity of the aquifer [L/T].
- $h$ is the hydraulic head [L].
- $\nabla h$ is the hydraulic gradient, which in three dimensions is written as:
 $$\nabla h = \left( \frac{\partial h}{\partial x}, \frac{\partial h}{\partial y}, \frac{\partial h}{\partial z} \right)$$

#### Step 2: Conservation of Mass

Consider a differential control volume in the unconfined aquifer with dimensions $dx$, $dy$, and $dz$, where $z$ is the vertical direction.

##### Inflow and Outflow

- Inflow in the $x$-direction at $x$: $Q_x(x) = q_x A_x = -K \frac{\partial h}{\partial x} A_x$, where $A_x = dy \cdot dz$ is the cross-sectional area perpendicular to the $x$-direction.
- Outflow in the $x$-direction at $x + dx$: $Q_x(x + dx) = \left( q_x + \frac{\partial q_x}{\partial x} dx \right) A_x$

Similarly, for the $y$- and $z$-directions:

- Inflow in the $y$-direction at $y$: $Q_y(y) = q_y A_y = -K \frac{\partial h}{\partial y} A_y$, where $A_y = dx \cdot dz$.
- Outflow in the $y$-direction at $y + dy$: $Q_y(y + dy) = \left( q_y + \frac{\partial q_y}{\partial y} dy \right) A_y$

- Inflow in the $z$-direction at $z$: $Q_z(z) = q_z A_z = -K \frac{\partial h}{\partial z} A_z$, where $A_z = dx \cdot dy$.
- Outflow in the $z$-direction at $z + dz$: $Q_z(z + dz) = \left( q_z + \frac{\partial q_z}{\partial z} dz \right) A_z$

##### Net Flow

The net inflow into the control volume is the sum of the net inflows in each direction:

$$\text{Net inflow in } x\text{-direction} = Q_x(x) - Q_x(x + dx)$$
$$= \left( -K \frac{\partial h}{\partial x} \right) A_x - \left( -K \frac{\partial h}{\partial x} + \frac{\partial}{\partial x} \left( -K \frac{\partial h}{\partial x} \right) dx \right) A_x$$
$$= - A_x \frac{\partial}{\partial x} \left( -K \frac{\partial h}{\partial x} \right) dx$$

Similarly,

$$\text{Net inflow in } y\text{-direction} = - A_y \frac{\partial}{\partial y} \left( -K \frac{\partial h}{\partial y} \right) dy$$
$$\text{Net inflow in } z\text{-direction} = - A_z \frac{\partial}{\partial z} \left( -K \frac{\partial h}{\partial z} \right) dz$$

The total net inflow into the control volume is:

$$\text{Net inflow} = - \left( \frac{\partial}{\partial x} \left( -K \frac{\partial h}{\partial x} \right) dx \cdot dy \cdot dz + \frac{\partial}{\partial y} \left( -K \frac{\partial h}{\partial y} \right) dx \cdot dy \cdot dz + \frac{\partial}{\partial z} \left( -K \frac{\partial h}{\partial z} \right) dx \cdot dy \cdot dz \right)$$
$$= \left( \frac{\partial}{\partial x} \left( K \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K \frac{\partial h}{\partial y} \right) + \frac{\partial}{\partial z} \left( K \frac{\partial h}{\partial z} \right) \right) dx \cdot dy \cdot dz$$

#### Step 3: Change in Storage

The change in storage within the control volume over a time interval $\Delta t$ can be expressed using the specific yield $S_y$, which is the volume of water released from storage per unit surface area per unit decline in the water table:

$$\Delta S = S_y \cdot dx \cdot dy \cdot dz \cdot \frac{\partial h}{\partial t} \cdot \Delta t$$

#### Step 4: Applying Conservation of Mass

According to the conservation of mass principle, the rate of change of storage in the control volume must equal the net rate of flow into the control volume:

$$S_y \frac{\partial h}{\partial t} \cdot dx \cdot dy \cdot dz = \left( \frac{\partial}{\partial x} \left( K \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K \frac{\partial h}{\partial y} \right) + \frac{\partial}{\partial z} \left( K \frac{\partial h}{\partial z} \right) \right) dx \cdot dy \cdot dz$$

#### Step 5: Simplifying and Rearranging

Divide through by $ dx \cdot dy \cdot dz $:

$$S_y \frac{\partial h}{\partial t} = \frac{\partial}{\partial x} \left( K \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K \frac{\partial h}{\partial y} \right) + \frac{\partial}{\partial z} \left( K \frac{\partial h}{\partial z} \right)$$

#### Final Governing Equation

The three-dimensional groundwater flow equation for an unconfined aquifer is:

$$S_y \frac{\partial h}{\partial t} = \frac{\partial}{\partial x} \left( K \frac{\partial h}{\partial x} \right) + \frac{\partial}{\partial y} \left( K \frac{\partial h}{\partial y} \right) + \frac{\partial}{\partial z} \left( K \frac{\partial h}{\partial z} \right)$$

This equation describes the transient groundwater flow in a three-dimensional unconfined aquifer, accounting for variations in the hydraulic head in all three spatial dimensions. This derivation does not rely on the Dupuit assumption, making it suitable for three-dimensional flow problems.

### 一维热传导方程
Let's go through the step-by-step derivation of the one-dimensional heat conduction equation based on Fourier's law in a structured manner.

#### Step 1: Fourier's Law of Heat Conduction
Fourier's law states that the heat flux $q$ (amount of heat per unit area per unit time) is proportional to the negative gradient of the temperature $T$:

$$q = -k \frac{\partial T}{\partial x}$$
where:

- $q$is the heat flux [W/m$^2$].
- $k$is the thermal conductivity of the material [W/(m·K)].
- $\frac{\partial T}{\partial x}$is the temperature gradient in the$x$-direction [K/m].

#### Step 2: Energy Conservation in a Differential Element
Consider a small differential control volume of length$dx$, cross-sectional area$A$, and located at position $x$ along the rod's length.

##### Heat Entering and Leaving the Control Volume

- The rate of heat entering at $x$: $q(x) \cdot A$
- The rate of heat leaving at $x + dx$: $q(x + dx) \cdot A$

Using a Taylor series expansion for $q(x + dx)$:

$$q(x + dx) \approx q(x) + \left( \frac{\partial q}{\partial x} \right) dx$$

##### Net Heat Flow
The net rate of heat entering the differential element is:
$$q(x) \cdot A - \left( q(x) + \left( \frac{\partial q}{\partial x} \right) dx \right) \cdot A$$

$$= -A \left( \frac{\partial q}{\partial x} \right) dx$$

#### Step 3: Heat Storage in the Differential Element
The change in internal energy ($\Delta U$) within the differential element over a time interval $\Delta t$ can be expressed using the specific heat capacity $c$ and density $\rho$ of the material:
$$\Delta U = \rho \cdot c \cdot A \cdot dx \cdot \frac{\partial T}{\partial t} \cdot \Delta t$$

#### Step 4: Applying Conservation of Energy
Assuming no internal heat generation and applying the conservation of energy principle, the rate of heat entering the control volume must equal the rate of energy storage within the control volume:
$$-A \left( \frac{\partial q}{\partial x} \right) dx = \rho \cdot c \cdot A \cdot dx \cdot \frac{\partial T}{\partial t}$$

#### Step 5: Substituting Fourier's Law
Substitute$q = -k \frac{\partial T}{\partial x}$into the equation:
$$-A \left( \frac{\partial}{\partial x} \left( -k \frac{\partial T}{\partial x} \right) \right) dx = \rho \cdot c \cdot A \cdot dx \cdot \frac{\partial T}{\partial t}$$

Simplify the equation:
$$A \left( k \frac{\partial^2 T}{\partial x^2} \right) dx = \rho \cdot c \cdot A \cdot dx \cdot \frac{\partial T}{\partial t}$$

#### Step 6: Simplifying and Rearranging
Cancel out the common terms$A$and$dx$:
$$k \frac{\partial^2 T}{\partial x^2} = \rho c \frac{\partial T}{\partial t}$$

Divide both sides by$\rho c$:
$$\frac{\partial T}{\partial t} = \frac{k}{\rho c} \frac{\partial^2 T}{\partial x^2}$$

Define the thermal diffusivity$\alpha$as:
$$\alpha = \frac{k}{\rho c}$$

#### Final Governing Equation
The one-dimensional heat conduction equation (also called the heat diffusion equation) is:
$$\frac{\partial T}{\partial t} = \alpha \frac{\partial^2 T}{\partial x^2}$$

This partial differential equation describes how the temperature $T$ varies with time $t$ and position $x$ within the material.

### 一维溶质运移-扩散方程
Sure, let's derive the governing equation for a one-dimensional solute advection-diffusion problem step by step. This equation describes how the solute concentration changes over time due to both advection (transport by the flow of the water) and diffusion (spreading due to concentration gradients).

#### Step-by-Step Derivation for One-Dimensional Solute Advection-Diffusion

#### Step 1: Define Variables

- $c(x, t)$: Solute concentration [M/L³].
- $u$: Velocity of the fluid in the x-direction [L/T].
- $D$: Diffusion coefficient [L²/T].
- $x$: Spatial coordinate in the x-direction [L].
- $t$: Time [T].

#### Step 2: Conservation of Mass (Continuity Equation)

Consider a differential control volume of length $dx$ in the x-direction.

##### Inflow and Outflow by Advection

- Inflow of solute by advection at position $x$:
 $$
  J_{\text{adv,in}} = u c(x, t)
 $$
  
- Outflow of solute by advection at position $ x + dx $:
 $$
  J_{\text{adv,out}} = u c(x + dx, t) \approx u \left( c(x, t) + \frac{\partial c}{\partial x} dx \right)
 $$

##### Inflow and Outflow by Diffusion

- Inflow of solute by diffusion at position $x$:
 $$
  J_{\text{diff,in}} = -D \frac{\partial c}{\partial x}
 $$

- Outflow of solute by diffusion at position $ x + dx $:
 $$
  J_{\text{diff,out}} = -D \frac{\partial c}{\partial x} \Bigg|_{x+dx} \approx -D \left( \frac{\partial c}{\partial x} + \frac{\partial}{\partial x} \left( \frac{\partial c}{\partial x} \right) dx \right)
 $$

#### Step 3: Net Flow

The net inflow of solute into the control volume is the difference between the inflow and outflow due to both advection and diffusion.

##### Net Advection Flow

$$
\text{Net advective flow} = J_{\text{adv,in}} - J_{\text{adv,out}} = u c(x, t) - u \left( c(x, t) + \frac{\partial c}{\partial x} dx \right) = -u \frac{\partial c}{\partial x} dx
$$

##### Net Diffusion Flow

$$
\text{Net diffusive flow} = J_{\text{diff,in}} - J_{\text{diff,out}} = -D \frac{\partial c}{\partial x} - \left( -D \left( \frac{\partial c}{\partial x} + \frac{\partial}{\partial x} \left( \frac{\partial c}{\partial x} \right) dx \right) \right) = D \frac{\partial^2 c}{\partial x^2} dx
$$

#### Step 4: Change in Storage

The change in solute mass within the control volume over a time interval $\Delta t$ is:

$$
\Delta S = \frac{\partial c}{\partial t} dx \Delta t
$$

#### Step 5: Applying Conservation of Mass

According to the conservation of mass principle, the rate of change of solute storage in the control volume must equal the net rate of solute flow into the control volume:

$$
\frac{\partial c}{\partial t} dx = -u \frac{\partial c}{\partial x} dx + D \frac{\partial^2 c}{\partial x^2} dx
$$

#### Step 6: Simplifying and Rearranging

Divide through by $dx$:

$$
\frac{\partial c}{\partial t} = -u \frac{\partial c}{\partial x} + D \frac{\partial^2 c}{\partial x^2}
$$

#### Final Governing Equation

The final governing equation for the one-dimensional solute advection-diffusion problem is:

$$
\frac{\partial c}{\partial t} + u \frac{\partial c}{\partial x} = D \frac{\partial^2 c}{\partial x^2}
$$

This partial differential equation describes how the solute concentration $c$ varies with time $t$ and position $x$ due to advection by the flow field $u$ and diffusion characterized by the diffusion coefficient $D$.

### 二维溶质运移-扩散方程
Let's derive the governing equation for a two-dimensional solute advection-diffusion problem step by step. This equation describes how a solute concentration changes over time due to both advection (transport by the flow of the water) and diffusion (spreading due to concentration gradients).

#### Step-by-Step Derivation for Two-Dimensional Solute Advection-Diffusion

#### Step 1: Define Variables

- $ c(x, y, t) $: solute concentration [M/L³].
- $u$: velocity component in the x-direction [L/T].
- $v$: velocity component in the y-direction [L/T].
- $D_x$: diffusion coefficient in the x-direction [L²/T].
- $D_y$: diffusion coefficient in the y-direction [L²/T].

#### Step 2: Conservation of Mass (Continuity Equation)

Consider a differential control volume in the $x$-$y$ plane with dimensions $dx$ and $dy$.

##### Inflow and Outflow

- Inflow of solute by advection in the $x$-direction at $x$:
 $$u(x) c(x) \cdot dy$$
- Outflow of solute by advection in the $x$-direction at $ x + dx $:
 $$u(x + dx) c(x + dx) \cdot dy \approx (u(x) c(x) + \frac{\partial}{\partial x} (u c) dx) \cdot dy$$

- Inflow of solute by advection in the $y$-direction at $y$:
 $$v(y) c(y) \cdot dx$$
- Outflow of solute by advection in the $y$-direction at $ y + dy $:
 $$v(y + dy) c(y + dy) \cdot dx \approx (v(y) c(y) + \frac{\partial}{\partial y} (v c) dy) \cdot dx$$

- Inflow of solute by diffusion in the $x$-direction at $x$:
 $$-D_x \frac{\partial c}{\partial x} \cdot dy$$
- Outflow of solute by diffusion in the $x$-direction at $ x + dx $:
 $$-D_x \frac{\partial c}{\partial x} \cdot dy - \frac{\partial}{\partial x} \left( -D_x \frac{\partial c}{\partial x} \right) dx \cdot dy$$

- Inflow of solute by diffusion in the $y$-direction at $y$:
 $$-D_y \frac{\partial c}{\partial y} \cdot dx$$
- Outflow of solute by diffusion in the $y$-direction at $ y + dy $:
 $$-D_y \frac{\partial c}{\partial y} \cdot dx - \frac{\partial}{\partial y} \left( -D_y \frac{\partial c}{\partial y} \right) dy \cdot dx$$

##### Net Flow

The net inflow of solute into the control volume due to advection and diffusion is:

$$\text{Net inflow in } x\text{-direction} = \left( u(x) c(x) \cdot dy - (u(x + dx) c(x + dx) \cdot dy) \right) + \left( -D_x \frac{\partial c}{\partial x} \cdot dy - \left( -D_x \frac{\partial c}{\partial x} - \frac{\partial}{\partial x} \left( -D_x \frac{\partial c}{\partial x} \right) dx \right) dy \right)$$
$$= - \frac{\partial}{\partial x} \left( u c \right) dx \cdot dy + \frac{\partial}{\partial x} \left( D_x \frac{\partial c}{\partial x} \right) dx \cdot dy$$

Similarly, for the $y$-direction:

$$\text{Net inflow in } y\text{-direction} = - \frac{\partial}{\partial y} \left( v c \right) dy \cdot dx + \frac{\partial}{\partial y} \left( D_y \frac{\partial c}{\partial y} \right) dy \cdot dx$$

The total net inflow of solute into the control volume is:

$$\text{Total net inflow} = \left( \frac{\partial}{\partial x} \left( D_x \frac{\partial c}{\partial x} \right) - \frac{\partial}{\partial x} \left( u c \right) \right) dx \cdot dy + \left( \frac{\partial}{\partial y} \left( D_y \frac{\partial c}{\partial y} \right) - \frac{\partial}{\partial y} \left( v c \right) \right) dy \cdot dx$$

#### Step 3: Change in Storage

The change in solute mass within the control volume over a time interval $ \Delta t $ is:

$$\Delta S = \frac{\partial c}{\partial t} \cdot dx \cdot dy \cdot \Delta t$$

#### Step 4: Applying Conservation of Mass

According to the conservation of mass principle, the rate of change of solute storage in the control volume must equal the net rate of solute flow into the control volume:

$$\frac{\partial c}{\partial t} = \left( \frac{\partial}{\partial x} \left( D_x \frac{\partial c}{\partial x} \right) - \frac{\partial}{\partial x} \left( u c \right) \right) + \left( \frac{\partial}{\partial y} \left( D_y \frac{\partial c}{\partial y} \right) - \frac{\partial}{\partial y} \left( v c \right) \right)$$

#### Step 5: Simplifying and Rearranging

Combine the terms and rearrange:

$$\frac{\partial c}{\partial t} = D_x \frac{\partial^2 c}{\partial x^2} + D_y \frac{\partial^2 c}{\partial y^2} - \frac{\partial}{\partial x} \left( u c \right) - \frac{\partial}{\partial y} \left( v c \right)$$

#### Final Governing Equation

The final governing equation for the two-dimensional solute advection-diffusion problem is:

$$\frac{\partial c}{\partial t} + \frac{\partial}{\partial x} (u c) + \frac{\partial}{\partial y} (v c) = D_x \frac{\partial^2 c}{\partial x^2} + D_y \frac{\partial^2 c}{\partial y^2}$$

This partial differential equation describes how the solute concentration $c$ varies with time $t$ and position $ (x, y) $ due to advection by the flow field $ (u, v) $ and diffusion characterized by the diffusion coefficients $D_x$ and $D_y$.
