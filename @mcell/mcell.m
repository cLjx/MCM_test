%% ����Ԫ���ڵ����Զ���
classdef mcell < handle
    properties
        state;%0��ʾ��ȼ�ꣻ1��ʾ����ȼ��2��ʾ��û�п�ʼ
        time;%��ʵ�ǻ�ʣ����ʱ�� С��0��ʾ���Խ����ˣ�game over��
        Qpre;%��ʵ�ǻ���������� С��0��ʾ����ȼ��
        Qall;%��ʵ�ǻ�ʣ�¶������� С��0��ʾ����Ϩ����
    end
    methods
        %����obj=mcell([time,Qpre,Qall],state)
        function this=mcell(varargin)
            nargin
            narginchk(1,2);
            this.time=varargin{1}(1);
            this.Qpre=varargin{1}(2);
            this.Qall=varargin{1}(3);
            this.state=varargin{2};
        end
        function set.state(this,index)
            this.state=index;
        end
    end
end

