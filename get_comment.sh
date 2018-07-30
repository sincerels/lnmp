#!/bin/bash 


#########################
#author:lishuo          #
#date:2018/07/25 	#
#version :v2		#
#mail:sincerels@163.com #
#########################



#爬取《我不是药神》影评，以及评论数，并以用户，满意度，评价的格式，进行存档


#看过的人数
KG(){
for ((i=0;i<200;i+=10));do

URL="https://movie.douban.com/subject/26752088/comments?start=$i&limit=20&sort=new_score&status=P"
curl $URL --insecure &> douban.txt

###############################



#影评
YP=`cat douban.txt  |grep '<span class="short"' |awk -F'>' '{print $2}'|sed  's#</span##g'` 
#用户名
YH=`grep '<a title=' douban.txt  |awk '{print $2}'  |awk '{print substr($1,7,19)}'` 
#感受
GS=`grep '<span class="allstar' douban.txt  |awk '{print $4}'  |awk '{print substr($1,8,2)}'`



cat  > user.txt <<EOF
$YH
$GS
$YP
EOF

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '1p;21p;41p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '2p;22p;42p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '3p;23p;43p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '4p;24p;44p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '5p;25p;45p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '6p;26p;46p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '7p;27p;47p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '8p;28p;48p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '9p;29p;49p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '10p;30p;50p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '11p;31p;51p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '12p;32p;52p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '13p;33p;53p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '14p;34p;54p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '15p;35p;55p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '16p;36p;56p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '17p;37p;57p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '18p;38p;58p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '19p;39p;59p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '20p;40p;60p' user.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
rm -rf /root/user.txt 
done
}

#人数统计
################################
#看过的人数
KGRS=`sed -n '/<li class="is-active">/{N;p}' douban.txt |grep -v '<li class="is-active">' |awk '{print substr($1,7,18)}'  |sed 's#</span>##' |tail -1`

#想看的人数
XKRS=`cat douban.txt  |grep -e '<a href="?status=F">'|awk '{print substr ($2,18,18)}' |sed  's#</a>##g' |tail -1` 

echo "看过的人数为: $KGRS"
echo "想看的人数为: $XKRS"
###############################

read -p "请输入执行结果的保存文件，输出结果会保存到此文件:" file 
echo -e "\033[34m 系统正在处理中... 保存的文件名称为$PWD/$file \033[0m"
echo -e "\033[32m 此文件为看过的影评  \033[0m"

echo -e "\033[32m please waitting,output file "$PWD/$file "\033[0m"

KG >> $PWD/$file


##################################################
##################################################

#想看的评论

XK(){
for ((i=0;i<200;i+=10));do
URL="https://movie.douban.com/subject/26752088/comments?start=$i&limit=20&sort=new_score&status=F"

curl $URL  &> douban1.txt
#影评
YP=`cat douban1.txt  |grep '<span class="short"' |awk -F'>' '{print $2}'|sed  's#</span##g'` 
#用户名
YH=`grep '<a title=' douban1.txt  |awk '{print $2}'  |awk '{print substr($1,7,19)}'` 
#感受
#GS=`grep '<span class="allstar' douban1.txt  |awk '{print $4}'  |awk '{print substr($1,8,2)}'`

cat  > user1.txt <<EOF
$YH
$YP
EOF

echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '1p;21p;41p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '2p;22p;42p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '3p;23p;43p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '4p;24p;44p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '5p;25p;45p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '6p;26p;46p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '7p;27p;47p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '8p;28p;48p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '9p;29p;49p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '10p;30p;50p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '11p;31p;51p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '12p;32p;52p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '13p;33p;53p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '14p;34p;54p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '15p;35p;55p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '16p;36p;56p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '17p;37p;57p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '18p;38p;58p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '19p;39p;59p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
sed -n '20p;40p;60p' user1.txt
echo -e "\033[35m~~~~~~~~~~~~~~~~~~~~~\033[0m"
rm -rf /root/user1.txt 
done
}
XK >> xiangkan.txt 
echo -e "\033[34m 想看的人员的评论   \033[0m"
echo -e "\033[34m ###############################################\033[0m"
echo -e "\033[32m 想看的人的影评输出到："$PWD/xiangkan.txt" 文件    \033[0m "

















