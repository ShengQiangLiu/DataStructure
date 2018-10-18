//
//  main.m
//  线性表_顺序存储_List
//
//  Created by 刘胜强 on 2018/10/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

#define MAXSIZE 20 // 最大存储的数据个数

typedef int Status;
typedef int ElemType;

typedef struct
{
    ElemType data[MAXSIZE];
    int length;
}Sqlist;

Status InitList(Sqlist *L)
{
    L->length = 0;
    return OK;
}

Status ElemInsert(Sqlist *L, int i, ElemType e)
{
    // List 已满
    if (L->length == MAXSIZE)
    {
        return ERROR;
    }
    // 插入的位置必须在 List 的第一位和最后一位之间
    if (i < 1 || i > L->length+1)
    {
        return ERROR;
    }
    // 从最后一个元素开始，将插入元素往后的元素往后挪一位
    for (int j = L->length-1; j >= i-1; j--)
    {
        L->data[j+1] = L->data[j];
    }
    // 赋值新的元素到插入的位置
    L->data[i-1] = e;
    L->length++;
    return OK;
}

Status ElemDelete(Sqlist *L, int i, ElemType *e)
{
    // 线性表不能为空
    if (L->length == 0)
    {
        return ERROR;
    }
    // 删除的位置必须在 List 范围内
    if (i < 1 || i > L->length)
    {
        return ERROR;
    }
    // 取出要删除的元素
    *e = L->data[i-1];
    // 从要删除的元素位置开始，将往后的元素往前挪动一位
    for (int j = i-1; j <= L->length-1; j++)
    {
        L->data[j] = L->data[j+1];
    }
    L->length--;
    return OK;
}

void ListLog(Sqlist L)
{
    for (int i = 1; i < L.length; i++)
    {
        printf("Elem %d = %d\n", i, L.data[i-1]);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        Sqlist list;
        InitList(&list);
        
        for (int i = 1; i < 8; i++)
        {
            ElemInsert(&list, i, i);
        }
        
        ListLog(list);
        
        ElemType elem;
        ElemDelete(&list, 3, &elem);
        
        ListLog(list);

    }
    return 0;
}
