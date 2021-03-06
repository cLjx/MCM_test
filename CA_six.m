clc;clear
disp('**************  welcome CA_SIX **************');
%% 第二问元胞自动机仿真测试 基本版
%     properties
%         T;loseQ;
%         state;%0表示已燃完；1表示正在燃；2表示还没有开始
%         Qpre;%其实是还差多少能量 小于0表示可以燃了
%         Qall;%其实是还剩下多少能量 小于0表示可以熄火了

%init
R=50;C=50;
QALL=12.3999;QPRE=0.63;
T=5;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
axis([-C/4*3-6 C/4*3+6 -R/4*3-6 R/4*3+6 ])
Map = [128,118,105;
    237,145,33;
    255,99,71;
    255,0,0;
    255,99,71 ;
    255,127,80;
    0 255 0]/255;
colormap(Map);
for i=1:R
    for j=1:C
        info=[2 QPRE QALL , 10  QALL/T];
        arr(i,j)=struct('state',info(1),'Qpre',info(2),'Qall',info(3), ...
            'T',info(4),'loseQ',info(5));
    end
end
arr(R/2,C/2).state=1;

out=false;Num=0;
arr_=arr;
% T=5;
% loseQ=1;;%每次少的能量
% preQ=1;%每次预热的能量
around=[0 -1;
    -1 0;1 0;
    -1 1;0 1;1 1;%偶数
    -1 -1;-1 0;1 0;
    0 -1 ;0 1;
    1 -1];

myAround=[-.5 -sqrt(3)/2;
    .5 -sqrt(3)/2;
    1 0;
    .5 sqrt(3)/2;
    -.5 sqrt(3)/2;
    -1 0];
PI=0.0887;PII=0.1613;%两类的比值
losePercent=[1/6 1/6 1/6 1/6 1/6 1/6 1/6 1/6 1/6 1/6 1/6 1/6];
disp(sprintf('元胞大小：%d * %d \n部分参数：T=%d \n Qall=%d \n Qpre=%d ', ...
    R,C,T,QALL,QPRE));
while true
    for i=1:R
        for j=1:C
            if arr(i,j).state==1
                arr_(i,j).Qall=arr_(i,j).Qall-arr_(i,j).loseQ;
                if arr_(i,j).Qall<=0
                    arr_(i,j).state=0;
                end
                ljx=[1 6;7 12];liu=mod(i,2);
                for k=ljx(1+liu,1):ljx(1+liu,2)%周围的扫描一下
                    if i+around(k,1)<=0 || j+around(k,2)<=0 || ...
                            i+around(k,1)>R || j+around(k,2)>C
                        continue;
                    end
                    if arr_(i+around(k,1),j+around(k,2)).state==2%还没烧
                        if i==1 || j==1 || i==R || j==C
                            continue;
                        end
                        arr_(i+around(k,1),j+around(k,2)).Qpre = ...
                            arr_(i+around(k,1),j+around(k,2)).Qpre- ...
                            arr_(i,j).loseQ * losePercent(k);
                        if arr_(i+around(k,1),j+around(k,2)).Qpre<=0
                            arr_(i+around(k,1),j+around(k,2)).state=1;
                        end
                    end
                end
            end
            %             cells(i,j)=arr(i,j).state+1;
            cells(i,j)=arr(i,j).Qall;
            
            add=0;
%             if mod(j,2)==0
%                 add=sqrt(3)/2;
%             end
            if mod(i,2)==0
                add=add+sqrt(3)/2;
            end
            I=3/2*(i-R/2);J=sqrt(3)*(j-C/2);
            color=[.5 .5 .5];
            if arr(i,j).state == 1
                color=[arr(i,j).Qall/QALL .5 .5];
            elseif arr(i,j).state == 2
                color=[0 1 0];
            end
            patch(myAround(:,1)'+I,myAround(:,2)'+J+add,color);
            axis([-C/4*3-6 C/4*3+6 -R/4*3-6 R/4*3+6 ])
        end
    end
    arr=arr_;
    if out || Num>37
        break;
    end
    %     imagesc(cells);
    pause(.0002);Num=Num+1;clf
end
disp('**************  end  **************');


