import { LightningElement, wire } from 'lwc';
import TechdicerChannel from '@salesforce/messageChannel/TechdicerChannel__c';
import { subscribe, MessageContext } from 'lightning/messageService';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Subscriber extends LightningElement {
    @wire(MessageContext)
    messageContext;
    message = '';

    subscription = null;

    connectedCallback() {
        this.subscribeMC();
    }

    subscribeMC() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(
            this.messageContext,
            TechdicerChannel,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        this.message = message ? message.message : 'no message payload';
    }

    disconnectedCallback() {
        this.unsubscribeMC();
    }

    unsubscribeMC() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}