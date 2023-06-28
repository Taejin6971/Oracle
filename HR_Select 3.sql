/* Select 3 */
/*  ���� �Լ�
    SYSDATE         : ���� �ý����� ��¥�� ����ϴ� �Լ�
    MONTHS_BETWEEN  : �� ��¥ ������ ���� ���� ���
    ADD_MONTHS      : Ư�� ��¥�� �������� ���Ҷ�
    NEXT_DAY        : Ư�� ��¥���� �ʷ��ϴ� ������ ���ڷ� �޾Ƽ� ������ �����ϴ� ��¥�� ���
    LAST_DAY        : ���� ������ ��¥�� ��ȯ
    ROUND           : ��¥�� �ݿø� �ϴ� �Լ�, 15�� �̻��̸� �ݿø� �̸��̸� ����
    TRUNC           : ��¥�� �߶󳻴� �Լ�
*/

-- ���� �ý����� ��¥ ��� : yy/mm/dd
select sysdate
from dual;

select sysdate -1 ����, sysdate ����, sysdate+1 ����
from dual;

select * from employee;

-- �Ի� �Ϸκ��� ���� ��¥���� ���� �ٹ��ߴ��� ���
select ename ���, hiredate �Ի���, round(sysdate-hiredate) �ѱٹ��ϼ�
from employee;

-- �Ի��Ϸ� ���� 1000�� ���� ������ ��¥�� ���
select ename ���, hiredate �Ի���, hiredate+1000 �Ի�1000�ϳ�¥
from employee;

-- Ư�� ��¥���� ���� �������� ���
select hiredate ����, trunc(hiredate, 'month'), round(hiredate, 'month')
from employee;

-- months_btween : �� ��¥ ������ �������� ���
-- �Ի��Ϸ� ���� ��������� �ٹ��� �������� ���
select ename, hiredate, trunc(months_between(sysdate, hiredate)) �ٹ�������
from employee;

-- date (��¥Ÿ��)
-- add_months (��¥, ������) : ��¥�� �������� ���ϴ� �Լ�
-- ���ó�¥�� 100������ ���� ��¥
select sysdate ���ó�¥, add_months(sysdate, 100) "100������", sysdate+100 "100����"
from dual;

-- �Ի��� 6������ ���� ����
select ename, hiredate, add_months(hiredate, 6) "�Ի��� 6��������"
from employee;

-- next_day : Ư�� ��¥���� ������ ��ǲ���� �־ �����ϴ� ������ ��¥�� ���
select next_day(sysdate, '��')
from dual;

-- last_day (date) : date�� ������ ��¥�� ���
select sysdate ���ó�¥, last_day(sysdate)
from dual;

-- ��� ���̺��� �Ի糯�� ��������¥ ���
select hiredate �Ի���, last_day(hiredate)
from employee;

/*  ���� ��ȯ �Լ�
    TO_CHAR     : ��¥, �������� ���������� ��ȯ
    TO_DATE     : �������� ��¥������ ��ȯ
    TO_NUMBER   : �������� ���������� ��ȯ
*/

-- to_char (date, 'YYYYMMDD') : ��¥������ 'YYYYMMDD'�������� �̾Ƽ� charŸ������ ��ȯ
select to_char(sysdate, 'yyyymmdd')
from dual;