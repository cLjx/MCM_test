%% ����Ԫ���ڵ����Զ���
classdef mcells < handle
    properties
        r=100;%��
        c=100;%��
        arr;
    end
    methods
        %����obj=mcells([r,c])
        function this=mcells(varargin)
%             narginchk(1,1);
            this.r=varargin{1}(1);
            this.c=varargin{1}(2);
            for i=1:this.r
                for j=1:this.c
                    this(i,j).arr=mcell([2,2,2],2);
                end
            end
        end
%         function set.arr(this,info)
%             this{info{1,1},info{1,2}}.arr.state=info{2,1};
%         end
    end
end

