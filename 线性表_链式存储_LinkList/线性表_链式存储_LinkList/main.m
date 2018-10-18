//
//  main.m
//  线性表_链式存储_LinkList
//
//  Created by 刘胜强 on 2018/10/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#include "stdio.h"
#include "stdlib.h"

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

typedef int Status;
typedef int ElemType;

/**
 定义结点
 */
typedef struct Node
{
    ElemType data; // 数据域
    struct Node *next; // 指针域
}Node;

typedef struct Node *LinkList; // 定义链表

Status InitList(LinkList *L)
{
    *L = (LinkList)malloc(sizeof(Node)); /* 产生头结点,并使L指向此头结点 */
    if (!(*L))
    {
        return ERROR;
    }
    (*L)->next = NULL; /* 指针域为空 */
    return OK;
}

Status ListInsert(LinkList *L, int i, ElemType elem)
{
    LinkList p, q;
    p = *L;
    int j = 1;
    while (p && j < i)
    {
        p = p->next; // 读取下一个结点
        ++j;
    }
    if (!p || j > i)
    {
        return ERROR;
    }
    // 创建一个新的结点
    q = (LinkList)malloc(sizeof(Node));
    q->data = elem; // 赋值新的数据
    q->next = p->next;
    p->next = q;
    
    return OK;
}

Status ListDelete(LinkList *L, int i, ElemType *elem)
{
    int j = 1;
    LinkList p, q;
    p = *L;
    while (p && j < i)
    {
        p = p->next;
        j++;
    }
    
    // 删除 i 位置的结点
    q = p->next;
    p->next = q->next;
    *elem = q->data;
    free(q);
    
    return OK;
}

void PrintList(LinkList L)
{
    LinkList p = L->next;
    while (p)
    {
        printf("Elem : %d\n", p->data);
        p = p->next;
    }
}

// 头插法
void CreateListHead(LinkList *L, int n)
{
    // 头结点
    *L = (LinkList)malloc(sizeof(Node));
    (*L)->next = NULL;
    LinkList p;
    for (int i = 0; i < n; i++)
    {
        // 将每一个新结点插入到第一个结点
        p = (LinkList)malloc(sizeof(Node));
        p->data = rand()%100;
        p->next = (*L)->next;
        (*L)->next = p;
    }
}

// 尾插法
void CreateListTail(LinkList *L, int n)
{
    LinkList p, r;
    // 创建链表
    *L = (LinkList)malloc(sizeof(Node));
    r = *L;
    for (int i = 0; i < n; i++)
    {
        p = (LinkList)malloc(sizeof(Node));
        p->data = rand()%100;
        r->next = p;
        r = p;
    }
    r->next = NULL; // 为尾结点
}

void ClearList(LinkList *L)
{
    LinkList p, q;
    p = (*L)->next;
    while (p)
    {
        q = p->next;
        free(p->next);
        p = q;
    }
    free((*L)->next);
    (*L)->next = NULL;

}

int main(int argc, const char * argv[])
{
    printf("Hello World!\n");
    
    LinkList L;
    InitList(&L);
    
    CreateListHead(&L, 10);
    
    ClearList(&L);
    
    CreateListTail(&L, 5);
    
    for (int i = 1; i<6; i++)
    {
        ListInsert(&L, i, i);
    }
    PrintList(L);

    
    ElemType elem;
    ListDelete(&L, 3, &elem);
    
    PrintList(L);

    
    return 0;
}
