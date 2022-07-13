import { LightningElement, track, wire, api } from 'lwc';
import getOppProd from '@salesforce/apex/getDataForTheThirdStep.getOppProd';;

export default class Modal extends LightningElement {
    oppProdList = []

    @track isModalOpen = false;
    @api item;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    submitDetails() {
        this.isModalOpen = false;
    }

    @wire(getOppProd, {oppId: '$item'})
    wiredAcc({data}){
        if(data){ 
            this.oppProdList = data
            console.log(this.oppProdList)
        }
    }

}