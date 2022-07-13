import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccountList from '@salesforce/apex/getDataForTheThirdStep.getAccountList';
import getAccount from '@salesforce/apex/getDataForTheThirdStep.getAccount';
import firstTemp from './data.html';
import secondTemp from './newtemp.html';
import findAccounts from '@salesforce/apex/Search.findAccounts';

export default class Data extends NavigationMixin(LightningElement) {
    accList;
    errorMessage = '';
    searchAccountName = '';
    dataSearch;
    showingAccounts;
    totalAccounts;
    accId = window.location.pathname.substring(21, window.location.pathname.lastIndexOf('/'));
    recs;
    error;

    render() {
        if (window.location.pathname == '/lightning/n/Statistics') {
            return firstTemp;
        } else {
            return secondTemp;
        }
    }

    viewRecord(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": event.currentTarget.dataset.id,
                "objectApiName": "Opportunity",
                "actionName": "view"
            },
        });
    }

    accountNameHandler(event) {
        this.searchAccountName = event.currentTarget.value;
        console.log('search', this.searchAccountName)
        if (!this.searchAccountName) {
            this.dataSearch = undefined;
            this.showingAccounts = this.totalAccounts;
            return;
        }
        findAccounts({ accName: this.searchAccountName })
            .then(result => {
                this.dataSearch = result;
                console.log('dataSearch', this.dataSearch);
            })
            .catch(error => {
                this.dataSearch = undefined;
                if (error) {
                    console.log(error);
                }
            })
    }

    @wire(getAccount, { accId: '$accId' })
    wiredAccount({ data }) {
        if (data) {
            this.accList = data;
            console.log(this.accList);
        }
    }

    @wire(getAccountList)
    wiredAccounts({ data }) {
        if (data) {
            console.log('data', data);
            this.totalAccounts = data;
        }
    }

    updateAccountHandler(event) {
        this.showingAccounts = [...event.detail.records];
        console.log('show', this.showingAccounts);
    }

    @wire(getAccount, { accId: '$accId' })
    listInfo({ error, data }) {
        if (data) {
            console.log('data', data);
            this.recs = data[0].Opportunities;
            console.log('data', this.recs);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.recs = undefined;
        }
    }
}