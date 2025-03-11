# 加载 pwndbg 配置文件
source /usr/lib/pwndbg/exe/gdbinit.py
# ==== 基础配置 ====
set debuginfod enabled on
set confirm off
set pagination off
set history save on
set history filename ~/.gdb_history
set print pretty on
set step-mode on

# ==== 显示增强 ====
# layout split
# 默认显示源码+汇编+寄存器窗口

# ==== 自定义命令 ====
# 快速计算字符串/数组长度 (需编译时带调试符号)
define myinit
    break main
    set logging file gdb_output.txt
    set logging enabled on
    record full
end

define slen
  if $arg0
    print (int)sizeof($arg0)/sizeof($arg0[0])
  end
end

# # 智能断点 (自动判断C++类成员函数)
# define b
#   if strchr($arg0, '::') != 0
#     break $arg0
#   else
#     break *$arg0
#   end
# end

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
# alias xh = x/xh             
# 查看2字节内存
# alias xw = x/xw             
# 查看4字节内存
# alias xg = x/gx             

# ==== 高级调试功能 ====
# 自动化崩溃分析
# define hook-stop
#   if $_siginfo
#     echo \n=== 崩溃信号 ===\n
#     info reg
#     echo \n=== 回溯 ===\n
#     bt full
#   end
# end

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

# document helpreverse
# 在记录模式下反向调试
# reverse-step 反单步
# reverse-next 源码级别
# reverse-continue 上一个断点
# record stop 停止记录
# end

# document helpthreads
# thread 3 切换到线程3
# info threads 列出所有线程
# thread apply all bt 所有线程打印调用栈
# set scheduler-locking on 锁定其他线程
# break main.c:30 thread 2 仅在线程2触发
# end

# document helpsignal
# handle SIGSEGV nostop 遇到SIGSEGV不暂停
# signal 0 继续执行并传递信号
# catch signal SIGUSR1 捕获自定义信号
# end

# document helpbreak_
# tbreak 触发一次后自动删除
# rbreak 正则
# end

# https://github.com/jerdna-regeiz/splitmind
set context-clear-screen on
set follow-fork-mode parent
source /home/poem/app/github/splitmind/gdbinit.py

python
import splitmind
(splitmind.Mind()
  .tell_splitter(show_titles=True)
  .tell_splitter(set_title="Main")
  .right(display="backtrace", size="25%")
  .above(of="main", display="disasm", size="80%", banner="top")
  .show("code", on="disasm", banner="none")
  .right(cmd='tty; tail -f /dev/null', size="65%", clearing=False)
  .tell_splitter(set_title='Input / Output')
  .above(display="stack", size="75%")
  .above(display="legend", size="25")
  .show("regs", on="legend")
  .below(of="backtrace", cmd="ipython", size="30%")
).build(nobanner=True)
end
set context-code-lines 30
set context-source-code-lines 30
set context-sections  "regs args code disasm stack backtrace"
