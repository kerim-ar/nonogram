#include "RecentNonogramsModel.h"

RecentNonogramsModel::RecentNonogramsModel(QObject * parent)
    :QAbstractListModel(parent)
{
    for (unsigned i = 0; i < 7; ++i) {
        m_recentNonograms.push_back( RecentNonogramData("D:/nonograms/Nonogram ", i) );
    }
}

int RecentNonogramsModel::rowCount(const QModelIndex &parent) const
{
    return m_recentNonograms.size();
}

QVariant RecentNonogramsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_recentNonograms.size()) {
        return QVariant();
    }
    if (role == Qt::DisplayRole)
    {
        return QVariant(m_recentNonograms[index.row()].Path());
    }
    return QVariant();
}
