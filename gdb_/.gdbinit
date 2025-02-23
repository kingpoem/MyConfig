# ==== 基础配置 ====
set debuginfod enabled on
set confirm off
set pagination off
set history save on
set history filename ~/.gdb_history
set print pretty on
set step-mode on

# ==== 显示增强 ====
break main
layout split
# 默认显示源码+汇编+寄存器窗口

# ==== 自定义命令 ====
# 快速计算字符串/数组长度 (需编译时带调试符号)
define slen
  if $arg0
    print (int)sizeof($arg0)/sizeof($arg0[0])
  end
end

# 智能断点 (自动判断C++类成员函数)
define b
  if strchr($arg0, '::') != 0
    break $arg0
  else
    break *$arg0
  end
end

# ==== 实用别名 ====
# 常用调试命令
# alias rc = run -c           
# 快速重跑命令
# alias bt = bt -n -f         
# 显示完整回溯(含文件地址)
# alias p/x = print/x         
# 十六进制打印
# alias p/a = print/x         
# 地址格式打印

# 内存操作
alias xh = x/xh             
# 查看2字节内存
alias xw = x/xw             
# 查看4字节内存
alias xg = x/gx             

# ==== 高级调试功能 ====
# 自动化崩溃分析
define hook-stop
  if $_siginfo
    echo \n=== 崩溃信号 ===\n
    info reg
    echo \n=== 回溯 ===\n
    bt full
  end
end

# 多线程调试助手
define thread
  set $cur_thread = $_thread
  printf "Thread %d (LWP %d)\n", $cur_thread.num, $cur_thread.ptid.lwp
  bt
end

# ==== 二进制分析增强 ====
# 查找内存地址属于哪个模块
define findmod
  if $argc == 1
    printf "模块: %s\n", $arg0 < $_siginfo._sifields._sigfault.si_addr ? "代码段" : "数据段"
  end
end

# ROP gadget搜索 (需安装ROPgadget)
define rop
  shell ROPgadget --binary "$_gdb_symfile" --norop --nosys
end

# 自动加载核心转储
define core
  exec-file core
  target core
  bt
end

# ==== 帮助系统 ====
document slen
计算数组/字符串长度 (需调试符号)
用法: slen variable_name
end

document thread
显示当前线程详细信息和回溯
用法: thread
end
