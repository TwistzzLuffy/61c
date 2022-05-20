#include <stddef.h>
#include "ll_cycle.h"

#define N 100000

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
   node *fast_ptr=head;
   node *slow_ptr=head;
   int sign=0;
   while(head!=NULL&&fast_ptr->next!=NULL&&slow_ptr->next!=NULL){
	fast_ptr=fast_ptr->next;
	if(fast_ptr->next==NULL){
		break;
	}	
	fast_ptr=fast_ptr->next;
        slow_ptr=slow_ptr->next;
	if(fast_ptr==slow_ptr){
		sign=1;
		break;
	}
   }
   return sign;
}

